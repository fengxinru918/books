<template>
  <el-form
    ref="formRef"
    :model="form"
    :rules="rules"
    label-width="120px"
    style="max-width: 800px; margin: 0 auto"
  >
    <el-form-item label="书籍名称" label-width="120px" prop="bookName">
      <el-col :span="20">
        <el-input
          v-model="form.bookName"
          placeholder="请输入书籍名称"
        ></el-input>
      </el-col>
    </el-form-item>
    <el-form-item label="书籍作者" label-width="120px" prop="author">
      <el-col :span="20">
        <el-input v-model="form.author" placeholder="请输入书籍作者"></el-input>
      </el-col>
    </el-form-item>
    <el-form-item label="总库存" label-width="120px" prop="amount">
      <el-col :span="20">
        <el-input
          v-model="form.amount"
          min="0"
          type="number"
          placeholder="请输入总库存"
        ></el-input>
      </el-col>
    </el-form-item>
    <el-form-item label="图书位置" label-width="120px" prop="position">
      <el-col :span="20">
        <el-autocomplete
          popper-class="my-autocomplete"
          v-model="form.position"
          :fetch-suggestions="querySearch"
          placeholder="请输入图书位置"
          @select="handleSelect"
          @input="handleInput"
        >
          <template #suffix>
            <i class="el-icon-edit el-input__icon"></i>
          </template>
          <template #default="{ item }">
            <div class="name">{{ item.position }}</div>
          </template>
        </el-autocomplete>
      </el-col>
    </el-form-item>
    <el-form-item label="图书图片" label-width="120px" prop="bookImage">
      <el-col :span="20">
        <el-upload
          class="upload-demo"
          :action="uploadUrl"
          :on-success="handleUploadSuccess"
          :on-error="handleUploadError"
          :on-remove="handleRemove"
        >
          <el-button type="primary" plain>点击上传图片</el-button>
        </el-upload>
        <div v-if="form.bookImage" class="image-preview">
          <img :src="form.bookImage" alt="预览图片" />
        </div>
      </el-col>
    </el-form-item>
    <el-form-item label="图书简介" label-width="120px" prop="bookDescription">
      <el-col :span="20">
        <el-input
          v-model="form.bookDescription"
          type="textarea"
          placeholder="请输入图书简介"
          :rows="5"
        ></el-input>
      </el-col>
    </el-form-item>
    <el-form-item>
      <el-col :span="20" :offset="4">
        <el-button type="primary" @click="addBook">立即添加</el-button>
      </el-col>
    </el-form-item>
  </el-form>
</template>

<script setup>
import { ref } from "vue";
import { useBooksStore } from "@/stores/books";
import { postAdminAddBooksAPI } from "@/api";
import qs from "qs";
import { ElMessage } from "element-plus";

const uploadUrl = ref("http://localhost:8980/upload");

// 定义 el-form 的 ref
const formRef = ref(null);

// 定义表单数据
const form = ref({
  bookName: "",
  author: "",
  amount: "",
  position: "",
  bookDescription: "",
  bookImage: "",
});

// 定义表单验证规则
const rules = ref({
  bookName: [{ required: true, message: "书籍名称不能为空", trigger: "blur" }],
  author: [{ required: true, message: "书籍作者不能为空", trigger: "blur" }],
  amount: [{ required: true, message: "总库存不能为空", trigger: "blur" }],
  bookImage: [{ required: true, message: "图书图片不能为空", trigger: "blur" }],
  position: [{ required: true, message: "图书位置不能为空", trigger: "blur" }],
  bookDescription: [
    { required: true, message: "图书简介不能为空", trigger: "blur" },
  ],
});

// 查询建议
const querySearch = (queryString, cb) => {
  const suggestions = useBooksStore().booksList.filter((item) =>
    item.position.includes(queryString)
  );
  cb(suggestions);
};

// 处理选择
const handleSelect = (item) => {
  form.value.position = item.position; 
};

// 处理输入
const handleInput = (value) => {
  form.value.position = value;
  console.log("form.value.position", value);
};

// 处理图片上传成功
const handleUploadSuccess = (res, file) => {
  if (res.status === 200) {
    // 返回url给bookImage
    form.value.bookImage = res.url;
  } else {
    ElMessage({
      showClose: true,
      message: res.msg || "上传失败，请稍后再试",
      type: "error",
    });
  }
};

// 处理图片上传失败进行提示
const handleUploadError = (err, file) => {
  ElMessage({
    showClose: true,
    message: "上传失败，请稍后再试",
    type: "error",
  });
};

// 处理图片移除
const handleRemove = (file) => {
  console.log("处理图片移除", file);
};

// 添加书籍
const addBook = async () => {
  // 校验
  if (!formRef) return;
  await formRef.value.validate();
  try {
    const res = await postAdminAddBooksAPI(form.value);
    if (res.status === 200) {
      ElMessage({
        showClose: true,
        message: res.msg,
        type: "success",
      });
      form.value = {
        bookName: "",
        author: "",
        amount: "",
        position: "",
        bookDescription: "",
        bookImage: "",
      };
      useBooksStore().postBooksData(); // 更新书籍列表
    } else {
      ElMessage({
        showClose: true,
        message: res.msg,
        type: "error",
      });
    }
  } catch (err) {
    ElMessage({
      showClose: true,
      message: "添加书籍失败，请稍后再试",
      type: "error",
    });
  }
};
</script>

<style lang="less" scoped>
.my-autocomplete {
  li {
    line-height: normal;
    padding: 7px;

    .name {
      text-overflow: ellipsis;
      overflow: hidden;
    }
    .addr {
      font-size: 12px;
      color: #b4b4b4;
    }

    .highlighted .addr {
      color: #ddd;
    }
  }
}

.image-preview {
  margin-top: 10px;
  text-align: center;
  img {
    max-width: 200px;
    max-height: 200px;
    border: 1px solid #ddd;
    border-radius: 4px;
    padding: 5px;
  }
}

.el-form-item {
  margin-bottom: 20px;
}

.el-input,
.el-textarea {
  width: 100%;
}

.el-button {
  width: 100%;
  max-width: 200px;
}
</style>
