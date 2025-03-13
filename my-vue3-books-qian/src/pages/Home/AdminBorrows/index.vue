<template>
  <div
    v-loading.fullscreen.lock="loading"
    :element-loading-text="loadingtext"
    element-loading-spinner="el-icon-loading"
    element-loading-background="rgba(0, 0, 0, 0.8)"
    class="all"
  >
    <el-input
      placeholder="请输入您要查找的用户姓名/图书名称按下回车键即可"
      :prefix-icon="Search"
      @keyup.enter="searchInfo"
      @blur="clear"
      v-model="info"
      class="comment-box"
    >
    </el-input>

    <el-table
      :data="flag === 0 ? borrowsList : searchMessage"
      style="width: 100%"
      :default-sort="{ prop: 'borrowDate', order: 'descending' }"
      height="660"
    >
      <el-table-column type="expand">
        <template #default="props">
          <el-form label-position="left" class="demo-table-expand">
            <el-form-item label="借阅日期：">
              <span>{{ props.row.borrowDate }}</span>
            </el-form-item>
            <el-form-item label="图书 ID:">
              <span>{{ props.row.bookId }}</span>
            </el-form-item>
            <el-form-item label="图书名称：">
              <span>{{ props.row.bookName }}</span>
            </el-form-item>
            <el-form-item label="读者编号：">
              <span>{{ props.row.readerId }}</span>
            </el-form-item>
            <el-form-item label="读者姓名：">
              <span>{{ props.row.readerName }}</span>
            </el-form-item>
            <el-form-item label="应还日期：">
              <span>{{ props.row.returnDate }}</span>
            </el-form-item>
            <el-form-item label="实际日期：">
              <span>{{ props.row.realDate }}</span>
            </el-form-item>
            <el-form-item label="书籍状态:">
              <span>{{ props.row.status }}</span>
              <template v-if="props.row.status === '未还'">
                <el-button
                  type="primary"
                  plain
                  @click="centerDialogVisible = true"
                  style="margin-left: 580px"
                >
                  提醒用户还书
                </el-button>

                <el-dialog
                  v-model="centerDialogVisible"
                  title="温馨提示"
                  width="500"
                  center
                  append-to-body
                >
                  <span> 确认发送邮件提醒用户还书吗？ </span>
                  <template #footer>
                    <div class="dialog-footer">
                      <el-button @click="centerDialogVisible = false"
                        >取消</el-button
                      >
                      <el-button
                        type="primary"
                        @click="alertPerson(props.$index, props.row)"
                      >
                        确认
                      </el-button>
                    </div>
                  </template>
                </el-dialog>
              </template>
            </el-form-item>
          </el-form>
        </template>
      </el-table-column>
      <el-table-column label="借阅日期" sortable prop="borrowDate">
      </el-table-column>
      <el-table-column label="图书名称" sortable prop="bookName">
        <template #default="scope">
          <el-tooltip placement="top" effect="light">
            <template #content>
              <div>
                编号：{{ scope.row.bookId }}<br />名称：{{ scope.row.bookName }}
              </div>
            </template>
            <el-button>{{ scope.row.bookName }}</el-button>
          </el-tooltip>
        </template>
      </el-table-column>
      <el-table-column label="读者姓名" sortable prop="readerName">
        <template #default="scope">
          <el-tooltip placement="top" effect="light">
            <template #content>
              <div>
                编号：{{ scope.row.readerId }}<br />名称：{{
                  scope.row.readerName
                }}
              </div>
            </template>
            <el-button>{{ scope.row.readerName }}</el-button>
          </el-tooltip>
        </template>
      </el-table-column>
      <el-table-column label="操作">
        <template #default="scope">
          <el-button
            type="danger"
            @click="handleDelete(scope.$index, scope.row)"
            >删除记录</el-button
          >
        </template>
      </el-table-column>
    </el-table>
  </div>
</template>

<script setup>
import { computed, ref, onMounted } from "vue";
import { useBorrowsStore } from "@/stores/borrows";
import { useUserStore } from "@/stores/user";
import { useBooksStore } from "@/stores/books";
import { postInitReaderListAPI } from "@/api";

import {
  postDeleteBorrowAPI,
  postSearchBorrowAPI,
  postAlertPersonAPI,
} from "@/api/index.js";
import qs from "qs";
import { ElMessage } from "element-plus";
import { Search } from "@element-plus/icons-vue";
const info = ref("");
const searchMessage = ref([]);
const centerDialogVisible = ref(false);
const flag = ref(0);
const loading = ref(false);
const loadingtext = ref("加载中...");
const borrowsStore = useBorrowsStore();
const userStore = useUserStore();
const booksStore = useBooksStore();
const borrowsList = computed(() => borrowsStore.borrowsList);
const readerId = ref(userStore.readerId);
// 删除记录
const handleDelete = async (index, row) => {
  const borrowObj = {
    readerId: row.readerId,
    bookId: row.bookId,
    borrowDate: row.borrowDate,
  };
  const res = await postDeleteBorrowAPI(qs.stringify(borrowObj));
  if (res.status === 200) {
    ElMessage({
      showClose: true,
      message: "删除借阅记录成功！",
      type: "success",
    });
    borrowsStore.postBorrowsListData({ readerId: readerId.value });
  }
};

// 搜书
const searchInfo = () => {
  if (info.value.trim() === "") {
    // 如果输入框为空，清空搜索结果并显示原始数据
    flag.value = 0; // 切换回原始数据状态
    searchMessage.value = [];
    return;
  }
  // 将搜索内容转为小写以实现大小写不敏感搜索
  const searchValue = info.value.trim().toLowerCase();
  // 基于搜索内容过滤 borrowsList
  const filteredList = borrowsList.value.filter((item) => {
    // 检查读者姓名或图书名称是否包含搜索内容
    return (
      item.readerName.toLowerCase().includes(searchValue) ||
      item.bookName.toLowerCase().includes(searchValue)
    );
  });
  // 将过滤后的结果赋值给 searchMessage
  searchMessage.value = filteredList;
  flag.value = 1; // 切换到搜索结果的显示状态
};
// 失去焦点清空
const clear = () => {
  flag.value = 0;
  searchMessage.value = [];
};

// 发邮件提醒还书
const alertPerson = async (index, row) => {
  centerDialogVisible.value = false;
  const res = await postAlertPersonAPI(
    qs.stringify({ readerId: row.readerId, bookName: row.bookName })
  );
  if (res.status === 200) {
    ElMessage({
      showClose: true,
      message: res?.msg || "提醒成功！",
      type: "success",
    });
  }
};

onMounted(() => {
  // 数据加载完成后，调用 postBorrowsListData
  borrowsStore.postBorrowsListData({ readerId: readerId.value });
});
</script>

<style lang="less" scoped>
.all {
  height: calc(100vh - 80px); /* 减去红色框的高度 */
  overflow-y: auto; /* 显示垂直滚动条 */
  position: relative; /* 确保子元素的绝对定位相对于此元素 */
}

.comment-box {
  position: sticky;
  top: 0; /* 固定在顶部 */
  background: white;
  padding: 10px;
  border-top: 1px solid #eee; /* 顶部边框 */
  z-index: 2; /* 确保在内容之上 */
}
:deep(.el-overlay-dialog) {
  z-index: 9999;
}
</style>
