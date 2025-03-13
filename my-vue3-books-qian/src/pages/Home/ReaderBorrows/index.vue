<template>
  <div>
    <el-table
      :data="borrows"
      style="width: 100%"
      height="660"
      v-loading.fullscreen.lock="loading"
      element-loading-text="正在处理..."
      element-loading-spinner="el-icon-loading"
      element-loading-background="rgba(0, 0, 0, 0.8)"
    >
      <el-table-column type="expand">
        <template #default="props">
          <el-form label-position="left" class="demo-table-expand">
            <el-form-item
              label="借书日期："
              v-if="props.row.borrowDate != '9999-12-31 00:00:00'"
            >
              <span>{{ props.row.borrowDate }}</span>
            </el-form-item>
            <el-form-item label="应还日期：">
              <span>{{ props.row.returnDate }}</span>
            </el-form-item>
            <el-form-item label="书籍名称：">
              <span>{{ props.row.bookName }}</span>
            </el-form-item>
            <el-form-item label="图书作者：">
              <span>{{ props.row.author }}</span>
            </el-form-item>
            <el-form-item label="图书状态：">
              <span>{{ props.row.status }}</span>
            </el-form-item>
          </el-form>
        </template>
      </el-table-column>
      <el-table-column prop="borrowDate" label="借阅日期" />
      <el-table-column prop="bookName" label="书籍名称" />
      <el-table-column prop="author" label="图书作者" />

      <el-table-column label="操作" width="200">
        <template #default="scope">
          <el-button disabled v-if="scope.row.status == '已还'">已还</el-button>
          <el-button
            type="primary"
            plain
            style="margin-right: 10px"
            @click="openReturn(scope.row)"
            v-if="scope.row.status != '已还' && !handleIfOverdue(scope.row)"
          >
            还书
          </el-button>
          <el-button
            type="success"
            :plain="scope.row.status == '未还'"
            :disabled="scope.row.status == '已续借'"
            v-if="scope.row.status != '已还' && !handleIfOverdue(scope.row)"
            @click="openContinue(scope.row)"
          >
            {{ scope.row.status == "已续借" ? "已续借" : "续借" }}
          </el-button>
        </template>
      </el-table-column>
    </el-table>

    <el-dialog title="扫码还书" v-model="returnVisible" width="30%">
      <div style="display: flex; flex-direction: column; align-items: center">
        <el-image
          style="width: 100px; height: 100px; margin-bottom: 30px"
          :src="codePng"
        />
        <el-button type="primary" @click="returnBook(currentRow)"
          >我已扫码，立即还书</el-button
        >
      </div>
    </el-dialog>
    <el-dialog title="扫码续借" v-model="continueVisible" width="30%">
      <div style="display: flex; flex-direction: column; align-items: center">
        <el-image
          style="width: 100px; height: 100px; margin-bottom: 30px"
          :src="codePng"
        />
        <el-button type="primary" @click="continueBorrowBook(currentRow)"
          >我已扫码，现在续借</el-button
        >
      </div>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from "vue";
import { postContinueBorrowAPI, postReturnBookAPI } from "@/api/index.js";
import Code from "@/assets/images/code.png";
import qs from "qs";
import { ElMessage } from "element-plus";
import { useUserStore } from "@/stores/user.js";
import { useBorrowsStore } from "@/stores/borrows.js";
import moment from "moment";

const userStore = useUserStore();
const borrowsStore = useBorrowsStore();
const loading = ref(false);
const overdueVisible = ref(false);
const returnVisible = ref(false);
const continueVisible = ref(false);
const codePng = ref(Code);
const currentRow = ref({});
const readerId = computed(() => userStore.readerId);
const borrows = computed(() => borrowsStore.borrows);
console.log("readerId", readerId.value);

// 判断是否逾期
const handleIfOverdue = (item) => {
  return new Date(item.returnDate) - new Date() < 0;
};

// 还书按钮
const openReturn = (row) => {
  currentRow.value = row;
  returnVisible.value = true;
};

// 续借按钮
const openContinue = (row) => {
  currentRow.value = row;
  continueVisible.value = true;
};

// 我已扫码，立即还书
const returnBook = async (row) => {
  const isOverdue = handleIfOverdue(row);
  if (isOverdue) {
    overdueVisible.value = true;
  }
  let infoObj = {
    bookId: row.bookId,
    readerId: row.readerId,
    borrowDate: row.borrowDate,
    status: "已还",
  };
  const res = await postReturnBookAPI(qs.stringify(infoObj));
  if (res.status == 200) {
    ElMessage({
      showClose: true,
      message: "还书成功！",
      type: "success",
    });
  }
  borrowsStore.postBorrowsData({ readerId: readerId.value });
};

// 我已扫码，现在续借
const continueBorrowBook = async (row) => {
  loading.value = true;
  let infoObj = {
    readerId: row.readerId,
    bookId: row.bookId,
    borrowDate: row.borrowDate,
    date: row.date,
    status: "已续借",
  };
  const res = await postContinueBorrowAPI(qs.stringify(infoObj));
  loading.value = false;
  console.log("续借", res);
  if (res.status == 200) {
    ElMessage({
      showClose: true,
      message: "续借成功！",
      type: "success",
    });
  }
  borrowsStore.postBorrowsData({ readerId: readerId.value });
};

onMounted(() => {
  borrowsStore.postBorrowsData({ readerId: readerId.value });
});
</script>
<style></style>
