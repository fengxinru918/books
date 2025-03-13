<template>
  <div>
    <el-table
      :data="reserve"
      style="width: 100%"
      height="660"
      v-loading.fullscreen.lock="loading"
      element-loading-text="正在处理..."
      element-loading-spinner="el-icon-loading"
      element-loading-background="rgba(0, 0, 0, 0.8)"
    >
      <el-table-column prop="date" label="预约日期"> </el-table-column>
      <el-table-column prop="bookName" label="书籍名称"> </el-table-column>
      <el-table-column prop="author" label="图书作者"> </el-table-column>
      <el-table-column label="操作" width="200">
        <template #default="scope">
          <el-popconfirm
            title="确认取消该预约吗？"
            style="margin-right: 10px"
            @confirm="cancelReserve(scope.$index, scope.row)"
            v-if="scope.row.status == '已预约'"
          >
            <el-button type="warning" plain>取消预约</el-button>
          </el-popconfirm>
          <el-button
            @click="openBorrow(scope.$index, scope.row)"
            v-if="scope.row.status == '已预约'"
            type="primary"
            plain
            >确认借书</el-button
          >
          <el-button disabled v-if="scope.row.status == '已借阅'"
            >已借阅</el-button
          >
        </template>
      </el-table-column>
    </el-table>
    <el-dialog
      title="扫码借书"
      v-model="borrowVisible"
      width="30%"
      @close="handleClose"
    >
      <div style="display: flex; flex-direction: column; align-items: center">
        <el-image
          style="width: 100px; height: 100px; margin-bottom: 30px"
          :src="Code"
        ></el-image>
        <el-button
          type="primary"
          @click="confirmBorrow(currentRow)"
          :disabled="isBorrowed"
          >我已扫码，确认借书</el-button
        >
      </div>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, onMounted, watchEffect } from "vue";
import { useReserveStore } from "@/stores/reserve";
import { useUserStore } from "@/stores/user";
import { ElMessage } from "element-plus";
import Code from "@/assets/images/code.png";
import { useBooksStore } from "@/stores/books";
import { postAddBorrowAPI } from "@/api";
import qs from "qs";
const booksStore = useBooksStore();
const reserveStore = useReserveStore();
const userStore = useUserStore();
const loading = ref(false);
const borrowVisible = ref(false);
const currentRow = ref({});
const codePng = ref(Code);
const reserve = ref([]);
const isBorrowed = ref(false);
const readerId = ref("");
// 确认借书
const openBorrow = (index, row) => {
  borrowVisible.value = true;
  currentRow.value = row;
  console.log("currentRow,", currentRow.value);
};
// 取消预约
const cancelReserve = async (index, row) => {
  const bookId = row.bookId;
  const readerId = userStore.readerId;
  const date = row.date;
  const obj = { bookId, readerId, date };
  try {
    const res = await reserveStore.postCancelReserveData(index, obj);
    if (res.status === 200) {
      reserveStore.removeReserveItem(index);
      ElMessage({
        showClose: true,
        message: "取消预约成功！",
        type: "success",
      });
    } else {
      ElMessage({
        showClose: true,
        message: "取消预约失败，请重试",
        type: "error",
      });
    }
  } catch (error) {
    console.error("取消预约失败：", error);
    ElMessage({
      showClose: true,
      message: "取消预约失败，请重试",
      type: "error",
    });
  }
};
// 我已扫码确认借书
const confirmBorrow = async (currentRow) => {
  try {
    let readerId = currentRow.readerId;
    let bookId = currentRow.bookId;
    let date = currentRow.date;
    let borrowObj = { readerId, bookId, date, status: "已预约" };
    const res = await postAddBorrowAPI(qs.stringify(borrowObj));

    if (res.status == 200) {
      ElMessage({
        showClose: true,
        message: res.msg,
        type: "success",
      });
      isBorrowed.value = true; // 设置为 true，禁用按钮
    }

    reserveStore.postReserveData(borrowObj);
  } catch (error) {
    console.error("确认借书失败：", error);
    ElMessage({
      showClose: true,
      message: "确认借书失败，请重试",
      type: "error",
    });
  }
};
const handleClose = () => {
  // 关闭对话框时刷新页面
  reserve.value = reserveStore.reserve;
  isBorrowed.value = false; // 设置为 true，禁用按钮
};
// 监听 reserveStore.reserve 的变化
watchEffect(() => {
  reserve.value = reserveStore.reserve;
});

onMounted(async () => {
  try {
    // 确保reserve加载数据
    await reserveStore.postReserveData({ readerId: userStore.readerId });
    console.log("reserve.value ", reserveStore.reserve);
  } catch (error) {
    console.error("获取数据失败：", error);
    ElMessage({
      showClose: true,
      message: "获取数据失败，请重试",
      type: "error",
    });
  } finally {
    loading.value = false;
  }
});
</script>
<style lang="less" scoped></style>
