<script setup>
import { ref, computed, reactive } from "vue";
import { ElMessage } from "element-plus";
import { useUserStore } from "@/stores/user.js";
import { useBooksStore } from "@/stores/books.js";
import { useCommentsStore } from "@/stores/comments.js";
import { useRouter } from "vue-router";
import axios from "axios";

import { postRegisterAPI, postLoginAPI, postCommentsAPI } from "@/api";
import qs from "qs";
import bg01 from "@/assets/images/bg01.jpg";
import bg02 from "@/assets/images/bg02.jpg";
import bg03 from "@/assets/images/bg03.jpg";
import bg04 from "@/assets/images/bg04.jpg";

const userStore = useUserStore();
const booksStore = useBooksStore();
const commentsStore = useCommentsStore();
const router = useRouter(); // 使用 useRouter 获取 router 实例
// 数据
const loginloading = ref(false);
const registerloading = ref(false);
const isAdmin = ref(false);
const flag = ref(1); //1为注册，0为登录
const bgImages = [bg01, bg02, bg03, bg04];
const loginMsg = reactive({
  phone: "",
  pwd: "",
});
const registerMsg = reactive({
  userName: "",
  phone: "",
  email: "",
  pwd: "",
});

// 计算属性
const loading = computed(() => loginloading.value || registerloading.value);
const loadingtext = computed(() => {
  if (loginloading.value && !registerloading.value) return "登录中...";
  if (!loginloading.value && registerloading.value) return "注册中...";
  return "拼命加载中...";
});
const ruleFormRef = ref();
// 校验
const rules = reactive({
  userName: [
    { required: true, message: "用户名不能为空", trigger: "blur" },
    { min: 3, max: 5, message: "长度应 3-5位", trigger: "blur" },
  ],
  phone: [
    {
      required: true,
      message: "手机号不能为空",
      trigger: "change",
    },
    {
      pattern: /^1[3-9]\d{9}$/,
      message: "请输入正确的手机号",
      trigger: "blur",
    },
  ],
  email: [
    {
      required: true,
      message: "邮箱不能为空",
      trigger: "change",
    },
    {
      pattern: /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/,
      message: "请输入正确的邮箱",
      trigger: "blur",
    },
  ],
  pwd: [
    {
      required: true,
      message: "请输入密码",
      trigger: "change",
    },
  ],
  desc: [
    {
      required: true,
      message: "请输入有效信息",
      trigger: "blur",
    },
  ],
});
// 注册按钮点击事件处理函数
const sendRegisterMsg = async () => {
  if (!ruleFormRef) return;
  // await ruleFormRef.value?.validate();
  // 设置注册加载状态
  registerloading.value = true;
  try {
    const data = qs.stringify({
      userName: registerMsg.userName,
      email: registerMsg.email,
      phone: registerMsg.phone,
      password: registerMsg.pwd,
    });
    const response = await postRegisterAPI(data);
    if (response.status === 200) {
      ElMessage({
        type: "success",
        message: "注册成功！",
      });
      // 跳转到登录页
      flag.value = 0;
      // 清空表单
      registerMsg.userName = "";
      registerMsg.email = "";
      registerMsg.phone = "";
      registerMsg.pwd = "";
    } else {
      ElMessage.error(response.msg || "注册失败！");
    }
  } catch (error) {
    console.error("注册过程中发生错误:", error);
    ElMessage({
      message: "注册过程中发生错误！",
      type: "warning",
    });
  } finally {
    registerloading.value = false;
  }
};
// 登录按钮
const sendLoginMsg = async () => {
  // 手机号密码校验
  if (!ruleFormRef) return;
  await ruleFormRef.value.validate();
  loginloading.value = true;
  const data = {
    phone: Number(loginMsg.phone), // 将 phone 转换为数字类型
    password: Number(loginMsg.pwd), // 将 password 转换为数字类型
    isAdmin: isAdmin.value,
  };
  // 校验通过发送请求
  const res = await postLoginAPI(data);
  if (isAdmin.value) {
    userStore.setAdminInfo(res.data);
  } else {
    userStore.setReaderInfo(res);
  }
  if (res.status === 200) {
    loginMsg.phone = data.phone;
    loginMsg.pwd = data.password;
    loginloading.value = false;
    ElMessage({
      showClose: true,
      message: "登录成功！",
      type: "success",
    });
    await booksStore.postBooksData();
    await commentsStore.postCommentsData();
    router.push({ path: `/home/introduce` });
  } else {
    ElMessage({
      showClose: true,
      message: "登录失败",
      type: "error",
    });
    loginloading.value = false;
  }
};
</script>

<template>
  <div
    class="login-wrap"
    v-loading="loading"
    :element-loading-text="loadingtext"
    element-loading-spinner="el-icon-loading"
    element-loading-background="rgba(0, 0, 0, 0.8)"
  >
    <div :class="{ 'right-panel-active': flag }" class="container">
      <!-- 注册 -->
      <div class="container_form container--signup">
        <el-form
          class="form"
          id="form1"
          ref="ruleFormRef"
          style="max-width: 600px"
          :model="registerMsg"
          :rules="rules"
          label-width="auto"
          status-icon
          autocomplete="off"
        >
          <h2 class="form_title">注册</h2>
          <el-form-item label="用户名：" prop="userName">
            <el-input v-model="registerMsg.userName" />
          </el-form-item>
          <el-form-item label="手机号：" prop="phone">
            <el-input v-model="registerMsg.phone" />
          </el-form-item>
          <el-form-item label="邮箱：" prop="email">
            <el-input v-model="registerMsg.email" />
          </el-form-item>
          <el-form-item label="密码：" prop="pwd">
            <el-input v-model="registerMsg.pwd" />
          </el-form-item>

          <el-button class="btn" @click="sendRegisterMsg(ruleFormRef)"
            >注册</el-button
          >
        </el-form>
      </div>

      <!-- 登录 -->
      <div class="container_form container--signin">
        <el-form
          class="form"
          id="form1"
          ref="ruleFormRef"
          style="max-width: 600px"
          :model="loginMsg"
          :rules="rules"
          label-width="auto"
          status-icon
          autocomplete="off"
        >
          <h2
            class="form_title"
            v-html="isAdmin ? '管理员登录' : '用户登录'"
          ></h2>
          <el-button
            v-if="isAdmin"
            class="button"
            type="primary"
            @click="isAdmin = false"
            plain
            >用户登录</el-button
          >
          <el-button
            v-else
            class="button"
            type="primary"
            @click="isAdmin = true"
            plain
            >管理员登录</el-button
          >
          <el-form-item label="手机号：" prop="phone">
            <el-input
              v-model="loginMsg.phone"
              placeholder="请输入手机号"
              clearable
              autocomplete="off"
            />
          </el-form-item>
          <el-form-item label="密码：" prop="pwd">
            <el-input
              v-model="loginMsg.pwd"
              type="password"
              placeholder="请输入密码"
              show-password
              clearable
              autocomplete="off"
            />
          </el-form-item>

          <a href="#" class="link">忘记密码?</a>
          <el-button class="btn" @click="sendLoginMsg(ruleFormRef)"
            >登录</el-button
          >
        </el-form>
      </div>

      <!-- 浮层 -->
      <div class="container_overlay">
        <div class="overlay">
          <div class="overlay_panel overlay--left">
            <el-button class="btn" @click="flag = 0" plain>登录</el-button>
          </div>
          <div class="overlay_panel overlay--right">
            <el-button class="btn" @click="flag = 1" plain>注册</el-button>
          </div>
        </div>
      </div>
    </div>

    <!-- 背景 -->
    <div class="slidershow">
      <div
        class="slidershow--image"
        :style="{ 'background-image': `url(${bg01})` }"
      ></div>
      <div
        class="slidershow--image"
        :style="{ 'background-image': `url(${bg02})` }"
      ></div>
      <div
        class="slidershow--image"
        :style="{ 'background-image': `url(${bg03})` }"
      ></div>
      <div
        class="slidershow--image"
        :style="{ 'background-image': `url(${bg04})` }"
      ></div>
    </div>
  </div>
</template>

<style lang="css" scoped>
:root {
  /* 颜色 */
  --white: #e9e9e9;
  --gray: #333;
  --blue: #095c91;
  --blue-r: #315a7491;
  --lightblue: #0393a3;

  /* 圆角 */
  --button-radius: 0.7rem;

  /* 大小 */
  --max-width: 758px;
  --max-height: 420px;

  font-size: 16px;
  font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
}

.login-wrap {
  align-items: center;
  background-color: #e9e9e9;
  background-attachment: fixed;
  background-position: center;
  background-repeat: no-repeat;
  background-size: cover;
  display: grid;
  height: 100vh;
  place-items: center;
}

.form_title {
  font-weight: 300;
  margin: 0;
  margin-bottom: 1.25rem;
}
.button {
  margin-bottom: 1.25rem;
}
:deep(.el-form-item__label) {
  padding: 0;
}
.link {
  color: #333;
  font-size: 0.9rem;
  text-decoration: none;
}

.container {
  background-color: #e9e9e9;
  border-radius: 0.7rem;
  box-shadow: 0 0.9rem 1.7rem rgba(0, 0, 0, 0.25),
    0 0.7rem 0.7rem rgba(0, 0, 0, 0.22);
  height: 420px;
  max-width: 758px;
  overflow: hidden;
  position: relative;
  width: 100%;
}

.container_form {
  height: 100%;
  position: absolute;
  top: 0;
  transition: all 0.6s ease-in-out;
}

.container--signin {
  left: 0;
  width: 50%;
  z-index: 5;
}

.container.right-panel-active .container--signin {
  transform: translateX(100%);
}

.container--signup {
  left: 0;
  opacity: 0;
  width: 50%;
  z-index: 4;
}

.container.right-panel-active .container--signup {
  -webkit-animation: show 0.6s;
  animation: show 0.6s;
  opacity: 1;
  transform: translateX(100%);
  z-index: 8;
}

.container_overlay {
  height: 100%;
  left: 50%;
  overflow: hidden;
  position: absolute;
  top: 0;
  transition: transform 0.6s ease-in-out;
  width: 50%;
  z-index: 100;
}

.container.right-panel-active .container_overlay {
  transform: translateX(-100%);
}

.overlay {
  background-color: rgba(255, 255, 255, 0.25);
  background-attachment: fixed;
  background-position: center;
  background-repeat: no-repeat;
  background-size: cover;
  height: 100%;
  left: -100%;
  position: relative;
  transform: translateX(0);
  transition: transform 0.6s ease-in-out;
  width: 200%;
}

.container.right-panel-active .overlay {
  transform: translateX(50%);
}

.overlay_panel {
  align-items: center;
  display: flex;
  flex-direction: column;
  height: 100%;
  justify-content: center;
  position: absolute;
  text-align: center;
  top: 0;
  transform: translateX(0);
  transition: transform 0.6s ease-in-out;
  width: 50%;
}

.overlay--left {
  transform: translateX(-20%);
}

.container.right-panel-active .overlay--left {
  transform: translateX(0);
}

.overlay--right {
  right: 0;
  transform: translateX(0);
}

.container.right-panel-active .overlay--right {
  transform: translateX(20%);
}

.btn {
  background-color: #095c91;
  background-image: linear-gradient(90deg, #095c91 0%, #0393a3 74%);
  border-radius: 20px;
  border: 0.2px solid #315a7491;
  color: #e9e9e9;
  cursor: pointer;
  font-size: 0.8rem;
  font-weight: bold;
  letter-spacing: 0.1rem;
  padding: 0.9rem 4rem;
  text-transform: uppercase;
  transition: transform 80ms ease-in;
}

.form > .btn {
  margin-top: 1.5rem;
}

.btn:active {
  transform: scale(0.95);
}

.btn:focus {
  outline: none;
}

.form {
  background-color: #e9e9e9;
  display: flex;
  align-items: center;
  justify-content: center;
  flex-direction: column;
  padding: 0 3rem;
  height: 100%;
  text-align: center;
}

.input {
  background-color: #fff;
  border: none;
  padding: 0.9rem 0.9rem;
  margin: 0.5rem 0;
  width: 100%;
}

@-webkit-keyframes show {
  0%,
  49.99% {
    opacity: 0;
    z-index: 4;
  }

  50%,
  100% {
    opacity: 1;
    z-index: 8;
  }
}

@keyframes show {
  0%,
  49.99% {
    opacity: 0;
    z-index: 4;
  }

  50%,
  100% {
    opacity: 1;
    z-index: 8;
  }
}

.slidershow {
  position: absolute;
  width: 100vw;
  height: 100vh;
  overflow: hidden;
}

.slidershow--image {
  position: absolute;
  width: 100%;
  height: 100%;
  background: no-repeat 50% 50%;
  background-size: cover;
  -webkit-animation-name: kenburns;
  animation-name: kenburns;
  -webkit-animation-timing-function: linear;
  animation-timing-function: linear;
  -webkit-animation-iteration-count: infinite;
  animation-iteration-count: infinite;
  -webkit-animation-duration: 16s;
  animation-duration: 16s;
  opacity: 1;
  -webkit-transform: scale(1.2);
  transform: scale(1.2);
}

.slidershow--image:nth-child(1) {
  -webkit-animation-name: kenburns-1;
  animation-name: kenburns-1;
  z-index: 3;
}

.slidershow--image:nth-child(2) {
  -webkit-animation-name: kenburns-2;
  animation-name: kenburns-2;
  z-index: 2;
}

.slidershow--image:nth-child(3) {
  -webkit-animation-name: kenburns-3;
  animation-name: kenburns-3;
  z-index: 1;
}

.slidershow--image:nth-child(4) {
  -webkit-animation-name: kenburns-4;
  animation-name: kenburns-4;
  z-index: 0;
}

@-webkit-keyframes kenburns-1 {
  0% {
    opacity: 1;
    -webkit-transform: scale(1.2);
    transform: scale(1.2);
  }
  1.5625% {
    opacity: 1;
  }
  23.4375% {
    opacity: 1;
  }
  26.5625% {
    opacity: 0;
    -webkit-transform: scale(1);
    transform: scale(1);
  }
  100% {
    opacity: 0;
    -webkit-transform: scale(1.2);
    transform: scale(1.2);
  }
  98.4375% {
    opacity: 0;
    -webkit-transform: scale(1.21176);
    transform: scale(1.21176);
  }
  100% {
    opacity: 1;
  }
}

@keyframes kenburns-1 {
  0% {
    opacity: 1;
    -webkit-transform: scale(1.2);
    transform: scale(1.2);
  }
  1.5625% {
    opacity: 1;
  }
  23.4375% {
    opacity: 1;
  }
  26.5625% {
    opacity: 0;
    -webkit-transform: scale(1);
    transform: scale(1);
  }
  100% {
    opacity: 0;
    -webkit-transform: scale(1.2);
    transform: scale(1.2);
  }
  98.4375% {
    opacity: 0;
    -webkit-transform: scale(1.21176);
    transform: scale(1.21176);
  }
  100% {
    opacity: 1;
  }
}

@-webkit-keyframes kenburns-2 {
  23.4375% {
    opacity: 1;
    -webkit-transform: scale(1.2);
    transform: scale(1.2);
  }
  26.5625% {
    opacity: 1;
  }
  48.4375% {
    opacity: 1;
  }
  51.5625% {
    opacity: 0;
    -webkit-transform: scale(1);
    transform: scale(1);
  }
  100% {
    opacity: 0;
    -webkit-transform: scale(1.2);
    transform: scale(1.2);
  }
}

@keyframes kenburns-2 {
  23.4375% {
    opacity: 1;
    -webkit-transform: scale(1.2);
    transform: scale(1.2);
  }
  26.5625% {
    opacity: 1;
  }
  48.4375% {
    opacity: 1;
  }
  51.5625% {
    opacity: 0;
    -webkit-transform: scale(1);
    transform: scale(1);
  }
  100% {
    opacity: 0;
    -webkit-transform: scale(1.2);
    transform: scale(1.2);
  }
}

@-webkit-keyframes kenburns-3 {
  48.4375% {
    opacity: 1;
    -webkit-transform: scale(1.2);
    transform: scale(1.2);
  }
  51.5625% {
    opacity: 1;
  }
  73.4375% {
    opacity: 1;
  }
  76.5625% {
    opacity: 0;
    -webkit-transform: scale(1);
    transform: scale(1);
  }
  100% {
    opacity: 0;
    -webkit-transform: scale(1.2);
    transform: scale(1.2);
  }
}

@keyframes kenburns-3 {
  48.4375% {
    opacity: 1;
    -webkit-transform: scale(1.2);
    transform: scale(1.2);
  }
  51.5625% {
    opacity: 1;
  }
  73.4375% {
    opacity: 1;
  }
  76.5625% {
    opacity: 0;
    -webkit-transform: scale(1);
    transform: scale(1);
  }
  100% {
    opacity: 0;
    -webkit-transform: scale(1.2);
    transform: scale(1.2);
  }
}

@-webkit-keyframes kenburns-4 {
  73.4375% {
    opacity: 1;
    -webkit-transform: scale(1.2);
    transform: scale(1.2);
  }
  76.5625% {
    opacity: 1;
  }
  98.4375% {
    opacity: 1;
  }
  100% {
    opacity: 0;
    -webkit-transform: scale(1);
    transform: scale(1);
  }
}

@keyframes kenburns-4 {
  73.4375% {
    opacity: 1;
    -webkit-transform: scale(1.2);
    transform: scale(1.2);
  }
  76.5625% {
    opacity: 1;
  }
  98.4375% {
    opacity: 1;
  }
  100% {
    opacity: 0;
    -webkit-transform: scale(1);
    transform: scale(1);
  }
}
</style>
