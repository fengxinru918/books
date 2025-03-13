<template>
  <div class="main">
    <!-- 折叠板 -->
    <el-radio-group v-model="isCollapse" style="margin-bottom: 40px">
      <el-radio-button :value="false">展开</el-radio-button>
      <el-radio-button :value="true">收起</el-radio-button>
    </el-radio-group>
    <el-menu
      default-active="1"
      class="el-menu-vertical-demo"
      :collapse="isCollapse"
      active-text-color="#50a5f8"
    >
      <!-- 首页 -->
      <el-tooltip
        class="box-item"
        effect="light"
        content="首页"
        placement="right"
      >
        <el-menu-item index="1" @click="$router.push('/home/introduce')">
          <el-icon><House /></el-icon>
          <span>首页</span>
        </el-menu-item>
      </el-tooltip>

      <!-- 用户管理 -->
      <el-tooltip
        class="box-item"
        effect="light"
        content="用户管理"
        placement="right"
      >
        <el-menu-item index="2" @click="$router.push('/home/person')">
          <el-icon color="#409efc"><Avatar /></el-icon>
          <span slot="title">用户管理</span>
        </el-menu-item>
      </el-tooltip>

      <!-- 图书管理 -->
      <el-tooltip
        class="box-item"
        effect="light"
        content="图书管理"
        placement="right"
      >
        <el-menu-item index="3" @click="$router.push('/home/search')">
          <el-icon><Memo /></el-icon>
          <span slot="title">图书管理</span>
        </el-menu-item>
      </el-tooltip>
      <!-- 借阅记录 -->
      <el-tooltip
        class="box-item"
        effect="light"
        content="借阅记录"
        placement="right"
      >
        <el-menu-item index="4" @click="$router.push('/home/adminborrows')">
          <el-icon><Search /></el-icon>
          <span slot="title">借阅记录</span>
        </el-menu-item>
      </el-tooltip>
      <!-- 预约记录 -->
      <el-tooltip
        class="box-item"
        effect="light"
        content="预约记录"
        placement="right"
      >
        <el-menu-item index="5" @click="$router.push('/home/adminreserve')">
          <el-icon><Calendar /></el-icon>
          <span slot="title">预约记录</span>
        </el-menu-item>
      </el-tooltip>
      <!-- 交流社区 -->
      <el-tooltip
        class="box-item"
        effect="light"
        content="交流社区"
        placement="right"
      >
        <el-menu-item index="6" @click="$router.push('/home/comment')">
          <el-icon><ChatDotSquare /></el-icon>
          <span slot="title">交流社区</span>
        </el-menu-item>
      </el-tooltip>
      <!-- 添加图书 -->
      <el-tooltip
        class="box-item"
        effect="light"
        content="添加图书"
        placement="right"
      >
        <el-menu-item index="7" @click="$router.push('/home/adminaddbooks')">
          <el-icon><DocumentAdd /></el-icon>
          <span slot="title">添加图书</span>
        </el-menu-item>
      </el-tooltip>
      <!-- 个人中心 -->
      <el-tooltip
        class="box-item"
        effect="light"
        content="个人中心"
        placement="right"
      >
        <el-menu-item index="8" @click="$router.push('/home/user')">
          <el-icon><User /></el-icon>
          <span slot="title">个人中心</span>
        </el-menu-item>
      </el-tooltip>
      <!-- 退出登录 -->
      <el-tooltip
        class="box-item"
        effect="light"
        content="退出登录"
        placement="right"
      >
        <el-menu-item index="9" @click="goLogin">
          <el-icon><SwitchButton /></el-icon>
          <span slot="title">退出登录</span>
        </el-menu-item>
      </el-tooltip>
    </el-menu>
  </div>
</template>

<script setup>
import { ref, onMounted, computed } from "vue";
import { useRouter } from "vue-router";
import { ElMessageBox, ElMessage } from "element-plus";
import {
  House,
  Calendar,
  Search,
  ChatDotSquare,
  User,
  Avatar,
  Memo,
  Switch,
  Setting,
  DocumentAdd,
  SwitchButton,
} from "@element-plus/icons-vue";
const isCollapse = ref(true);
const router = useRouter();

// 返回登录页
const goLogin = () => {
  ElMessageBox.confirm("确认退出登录吗？", "温馨提示", {
    confirmButtonText: "确定",
    cancelButtonText: "取消",
    type: "warning",
  })
    .then(async () => {
      router.push({
        path: `/LoginRegister`,
      });
    })
    .catch(() => {});
};
</script>

<style lang="less" scoped>
.main {
  float: left;
  margin-right: 200px;
}
:deep(.el-menu-item) {
  height: 76px;
}
</style>
