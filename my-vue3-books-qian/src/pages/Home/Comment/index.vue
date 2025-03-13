<template>
  <div class="clearfix wrap">
    <div class="comments-container">
      <!-- 有评论时 -->
      <template v-if="comments.length > 0">
        <div
          class="comment"
          v-for="(comment, index) in comments"
          :key="index"
          v-show="comment.status != 0"
        >
          <span class="bookname">《{{ comment.bookName }}》</span>
          <el-badge :value="comment.praise" class="praise">
            <el-button @click="addPraise(comment.commentId)">点赞</el-button>
          </el-badge>
          <template v-if="isAdmin">
            <el-button
              class="praise"
              plain
              @click="delComment(comment.commentId)"
              >删除</el-button
            >
          </template>
          <div class="reader">{{ comment.readerName }}</div>
          <div class="time">{{ comment.date }}</div>
          <div class="content">{{ comment.content }}</div>
          <div class="kong"></div>
        </div>
      </template>
      <!-- 无评论时 -->
      <div v-else class="no-comments">
        <el-empty description="暂无评论"></el-empty>
      </div>
    </div>
    <!-- 底部评论框 -->
    <div class="comment-box" v-if="!isAdmin">
      <el-select
        v-model="selectedBookId"
        placeholder="请选择书籍"
        @change="handleBookSelect"
      >
        <el-option
          v-for="item in booksList"
          :key="item.bookId"
          :label="item.bookName"
          :value="item.bookId"
        >
        </el-option>
      </el-select>

      <el-input
        class="textarea"
        type="textarea"
        :rows="2"
        placeholder="请输入内容"
        v-model="commentsList.textarea"
      >
      </el-input>
      <el-button type="primary" plain class="sendcomment" @click="sendcomment"
        >发表评论</el-button
      >
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, computed } from "vue";
import {
  postAddPraiseAPI,
  postAddCommentAPI,
  postDelCommentAPI,
  postCommentsAPI,
} from "/src/api/index.js";
import { useCommentsStore } from "@/stores/comments";
import { useUserStore } from "@/stores/user";
import { useBooksStore } from "@/stores/books";
import { ElMessageBox, ElMessage } from "element-plus";
import qs from "qs";
import moment from "moment";

const commentsStore = useCommentsStore();
const booksStore = useBooksStore();
const userStore = useUserStore();
const isAdmin = computed(() => userStore.isAdmin);
const { booksList } = booksStore;
const { commentsList } = commentsStore;
const comments = ref(commentsList);

// 选中的书籍ID
const selectedBookId = ref("");

// 发表评论
const sendcomment = async () => {
  if (!commentsList.textarea) {
    ElMessage({
      showClose: true,
      message: "评论内容不能为空，请输入评论内容！",
      type: "warning",
    });
    return;
  }
  if (!selectedBookId.value) {
    ElMessage({
      showClose: true,
      message: "请选择书籍！",
      type: "warning",
    });
    return;
  }
  const selectedBook = booksList.find(
    (book) => book.bookId === selectedBookId.value
  );
  if (!selectedBook) {
    ElMessage({
      showClose: true,
      message: "书籍信息异常，请重新选择书籍！",
      type: "error",
    });
    return;
  }
  let dataObj = {
    readerId: userStore.readerId,
    readerName: userStore.readerName,
    bookId: selectedBookId.value,
    bookName: selectedBook.bookName,
    content: commentsList.textarea.trim(),
  };
  try {
    const res = await postAddCommentAPI(qs.stringify(dataObj));
    if (res.status === 200) {
      ElMessage({
        showClose: true,
        message: "评论成功！",
        type: "success",
      });
      selectedBookId.value = "";
      commentsList.textarea = "";
      commentsList.unshift({
        ...dataObj,
        date: moment().format("YYYY-MM-DD HH:mm:ss"),
        praise: 0,
        status: 1,
      });
      await commentsStore.postCommentsData();
    }
  } catch (error) {
    ElMessage({
      showClose: true,
      message: "评论失败，请稍后重试！",
      type: "error",
    });
    console.error("评论失败：", error);
  }
};

// 添加点赞
const addPraise = async (commentId) => {
  try {
    const res = await postAddPraiseAPI(qs.stringify({ commentId }));
    if (res.status === 200) {
      ElMessage({
        showClose: true,
        message: "点赞成功！",
        type: "success",
      });
      const commentIndex = commentsList.findIndex(
        (item) => item.commentId === commentId
      );
      if (commentIndex !== -1) {
        commentsList[commentIndex].praise += 1;
      }
      await commentsStore.postCommentsData();
    }
  } catch (error) {
    ElMessage({
      showClose: true,
      message: "点赞失败，请稍后重试！",
      type: "error",
    });
    console.error("点赞失败：", error);
  }
};

// 删除评论
const delComment = async (commentId) => {
  ElMessageBox.confirm("确认删除该评论吗？", "温馨提示", {
    confirmButtonText: "确定",
    cancelButtonText: "取消",
    type: "warning",
  })
    .then(async () => {
      await confirmDelComment(commentId);
    })
    .catch(() => {});
};
// 确认删除评论
const confirmDelComment = async (commentId) => {
  try {
    const res = await postDelCommentAPI(qs.stringify({ commentId }));
    if (res.status === 200) {
      ElMessage({
        showClose: true,
        message: "删除评论成功！",
        type: "success",
      });
      comments.value = commentsList.filter(
        (item) => item.commentId !== commentId
      );
      await commentsStore.postCommentsData();
    } else {
      ElMessage({
        showClose: true,
        message: "删除评论失败，请稍后重试！",
        type: "error",
      });
    }
  } catch (error) {
    ElMessage({
      showClose: true,
      message: "删除评论失败，请稍后重试！",
      type: "error",
    });
    console.error("删除评论失败：", error);
  }
};

// 监听书籍选择
const handleBookSelect = (value) => {
  selectedBookId.value = value;
};

onMounted(async () => {
  await commentsStore.postCommentsData();
  booksStore.booksList;
});
</script>
<style lang="less" scoped>
.wrap {
  position: relative;
  height: 100vh;
  display: flex;
  flex-direction: column;
  .comments-container {
    flex: 1;
    overflow-y: auto;
    padding-bottom: 20px;
    .comment {
      position: relative;
      padding-top: 10px;
      .bookname {
        color: rgb(97, 90, 90);
      }
      .report {
        float: right;
      }
      .praise {
        float: right;
        margin-right: 20px;
      }
      .del {
        float: right;
        margin-right: 10px;
      }
      .time {
        font-family: inherit;
        font-style: italic;
        font-size: small;
        color: #79cde2;
        margin: 10px;
      }
      .reader {
        font-style: italic;
        font-family: Arial;
        color: rgb(48, 138, 138);
        position: absolute;
        bottom: 5px;
        right: 50px;
      }
      .content {
        text-indent: 2em;
        color: #f56c6c;
      }
    }
  }
  .comment-box {
    position: sticky;
    bottom: 20px;
    background: white;
    padding: 10px;
    border-top: 1px solid #eee;
    .textarea {
      margin-top: 20px;
    }
    .sendcomment {
      margin-top: 20px;
      margin-left: 88%;
    }
  }
}
.kong {
  width: 100%;
  height: 1px;
  background: #ccc;
}
.no-comments {
  text-align: center;
  padding: 40px 0;
  color: #999;
}
:deep(.el-badge__content.is-fixed) {
  z-index: auto; /* 设置为 auto */
}
</style>
