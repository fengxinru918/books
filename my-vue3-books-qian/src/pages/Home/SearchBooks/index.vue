<template>
  <el-input
    placeholder="请输入您要搜索的书名/作者"
    prefix-icon="el-icon-search"
    @keyup.enter="handleSearchBook"
    @blur="clear"
    v-model="name"
  >
  </el-input>
  <el-table
    :data="flag == 0 ? booksList : searchBooks"
    height="660"
    style="width: 100%"
    v-loading.fullscreen.lock="loading"
    element-loading-text="正在处理..."
    element-loading-spinner="el-icon-loading"
    element-loading-background="rgba(0, 0, 0, 0.8)"
  >
    <el-table-column type="expand">
      <template #default="props">
        <div class="expanded-content">
          <!-- 左侧：图片和概述 -->
          <div class="left-section">
            <img :src="props.row.bookImage" alt="书籍图片" class="book-image" />
            <div class="book-description">
              <p>{{ props.row.bookDescription }}</p>
            </div>
          </div>
          <!-- 右侧：其他信息 -->
          <div class="right-section">
            <el-form label-position="left" class="info-form">
              <el-form-item label="图书名称：">
                <span>{{ props.row.bookName }}</span>
                <el-button
                  v-show="isAdmin"
                  @click="changeBookName(props.row)"
                  type="text"
                  style="float: right"
                  icon="el-icon-edit"
                  >修改</el-button
                >
              </el-form-item>
              <el-form-item label="图书作者：">
                <span>{{ props.row.author }}</span>
                <el-button
                  v-show="isAdmin"
                  @click="changeBookAuthor(props.row)"
                  type="text"
                  style="float: right"
                  icon="el-icon-edit"
                  >修改</el-button
                >
              </el-form-item>
              <el-form-item label="书籍位置：">
                <span>{{ props.row.position }}</span>
                <el-button
                  v-show="isAdmin"
                  @click="changeBookPosition(props.row)"
                  type="text"
                  style="float: right"
                  icon="el-icon-edit"
                  >修改</el-button
                >
              </el-form-item>
              <el-form-item label="当前库存：">
                <span>{{ props.row.amount }}</span>
                <el-button
                  v-show="isAdmin"
                  @click="changeCurrentAmount(props.row)"
                  type="text"
                  style="float: right"
                  icon="el-icon-edit"
                  >修改</el-button
                >
              </el-form-item>
              <el-form-item label="总库存：">
                <span>{{ props.row.totalAmount }}</span>
              </el-form-item>
              <el-form-item label="借阅次数：">
                <span>{{ props.row.borrowedTimes }}</span>
                <el-button
                  plain
                  v-show="isAdmin"
                  type="primary"
                  style="margin-left: 92px"
                  @click="delBook(props.row)"
                  >删除图书</el-button
                >
              </el-form-item>
            </el-form>
          </div>
        </div>
      </template>
    </el-table-column>
    <el-table-column label="图书图片" sortable prop="bookImage">
      <template #default="scope">
        <img
          :src="scope.row.bookImage"
          alt="图书图片"
          style="width: 50px; height: auto"
        />
      </template>
    </el-table-column>
    <el-table-column label="图书名称" sortable prop="bookName">
    </el-table-column>
    <el-table-column sortable label="图书作者" prop="author"> </el-table-column>
    <el-table-column sortable label="书籍位置" prop="position">
    </el-table-column>
    <el-table-column sortable label="当前库存" prop="amount"> </el-table-column>
    <el-table-column label="操作" v-if="!isAdmin">
      <template #default="scope">
        <el-button
          type="primary"
          plain
          @click="bookReserve(scope.$index, scope.row)"
          >预约</el-button
        >
      </template>
    </el-table-column>
  </el-table>
</template>

<script setup>
import { ref, computed, onMounted } from "vue";
import { useUserStore } from "@/stores/user";
import { useReserveStore } from "@/stores/Reserve";
import { useBooksStore } from "@/stores/books";
import {
  postAddReserveAPI,
  postReserveAPI,
  postSearchBookAPI,
  postChangeBookInfoAPI,
  postDelBookAPI,
} from "@/api";
import qs from "qs";
import moment from "moment";
import { ElMessageBox, ElMessage } from "element-plus";

const userStore = useUserStore();
const booksStore = useBooksStore();
const reserveStore = useReserveStore();
const loading = ref(false);
const name = ref("");
const flag = ref(0);
const borrowInfo = ref({
  borrowDate: "",
  realDate: "",
});
const searchBooks = ref([]);

const booksList = computed(() => booksStore.booksList);
const readerId = computed(() => userStore.readerId);
const isAdmin = computed(() => userStore.isAdmin);
// 预约
const bookReserve = async (index, row) => {
  loading.value = true;
  let readerIdVal = readerId.value;
  let bookId = row.bookId;
  let date = moment().format("YYYY-MM-DD HH:mm:ss");
  let reserveObj = { readerId: readerIdVal, bookId, date, status: "已预约" };
  const res = await postAddReserveAPI(qs.stringify(reserveObj));
  loading.value = false;
  if (res.status == 0) {
    ElMessage({
      showClose: true,
      message: res.msg,
      type: "error",
    });
  } else if (res.status == 200) {
    ElMessage({
      showClose: true,
      message: res.msg,
      type: "success",
    });
  }
  reserveStore.postReserveData(readerIdVal);
};
// 查找图书
const handleSearchBook = async (e) => {
  loading.value = true;
  const res = await postSearchBookAPI(qs.stringify({ name: name.value }));
  loading.value = false;
  e.target.blur();
  flag.value = 1;
  searchBooks.value = res.data;
  if (res.status == 0) {
    ElMessage({
      showClose: true,
      message: "未找到相关书籍！",
      type: "error",
    });
  }
};

const clear = () => {
  flag.value = 0;
  searchBooks.value = [];
};
// 查找书名
const changeBookName = (row) => {
  ElMessageBox.prompt("请输入书名", "提示", {
    confirmButtonText: "确定",
    cancelButtonText: "取消",
    inputValue: row.bookName,
  })
    .then(({ value }) => {
      ElMessage({
        type: "success",
        message: "你修改的书名是: " + value,
      });
      const infoObj = { bookId: row.bookId, value, status: 1 };
      postChangeBookInfoAPI(qs.stringify(infoObj));
    })
    .catch(() => {
      ElMessage({
        type: "info",
        message: "取消输入",
      });
    });
};
// 查找作者
const changeBookAuthor = (row) => {
  ElMessageBox.prompt("请输入作者名", "提示", {
    confirmButtonText: "确定",
    cancelButtonText: "取消",
    inputValue: row.author,
  })
    .then(({ value }) => {
      ElMessage({
        type: "success",
        message: "你修改的作者名是: " + value,
      });
      const infoObj = { bookId: row.bookId, value, status: 2 };
      postChangeBookInfoAPI(qs.stringify(infoObj));
    })
    .catch(() => {
      ElMessage({
        type: "info",
        message: "取消输入",
      });
    });
};
// 修改图书位置
const changeBookPosition = (row) => {
  ElMessageBox.prompt("请输入位置", "提示", {
    confirmButtonText: "确定",
    cancelButtonText: "取消",
    inputValue: row.position,
  })
    .then(({ value }) => {
      ElMessage({
        type: "success",
        message: "你修改的位置是: " + value,
      });
      const infoObj = { bookId: row.bookId, value, status: 3 };
      postChangeBookInfoAPI(qs.stringify(infoObj));
    })
    .catch(() => {
      ElMessage({
        type: "info",
        message: "取消输入",
      });
    });
};
// 修改图书总量
const changeCurrentAmount = (row) => {
  ElMessageBox.prompt("请输入库存", "提示", {
    confirmButtonText: "确定",
    cancelButtonText: "取消",
    inputValue: row.amount,
  })
    .then(({ value }) => {
      ElMessage({
        type: "success",
        message: "你修改当前库存是: " + value,
      });
      const infoObj = { bookId: row.bookId, value, status: 4 };
      postChangeBookInfoAPI(qs.stringify(infoObj));
    })
    .catch(() => {
      ElMessage({
        type: "info",
        message: "取消输入",
      });
    });
};
// 删除图书
const delBook = (row) => {
  ElMessageBox.confirm("确定删除该图书吗?", "Warning", {
    confirmButtonText: "确认",
    cancelButtonText: "取消",
    type: "warning",
  })
    .then(async () => {
      const res = await postDelBookAPI(qs.stringify({ bookId: row.bookId }));
      if (res.status == 200) {
        ElMessage({
          type: "success",
          message: "删除图书成功",
        });
        // 刷新书籍列表
        booksStore.postBooksData();
      }
    })
    .catch(() => {
      ElMessage({
        type: "info",
        message: "取消删除",
      });
    });
};
onMounted(() => {
  booksStore.postBooksData();
});
</script>

<style lang="less" scoped>
.expanded-content {
  display: flex;
  gap: 20px;
}

.left-section {
  flex: 1;
  display: flex;
  flex-direction: column;
  align-items: center;
}

.book-image {
  max-width: 160px;

  margin-bottom: 10px;
}

.book-description {
  font-size: 14px;
  color: #666;
  text-align: center;
}

.right-section {
  flex: 2;
  margin-left: 60px;
  .info-form {
    .el-form-item {
      margin-bottom: 15px;
    }
  }
}
</style>
