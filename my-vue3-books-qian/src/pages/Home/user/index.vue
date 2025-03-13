

<template>
  <el-descriptions
    :title="isAdmin ? '管理员信息' : '用户信息'"
    direction="vertical"
    border
    style="margin-top: 20px"
  >
    <el-descriptions-item
      :rowspan="2"
      :width="140"
      label="头像"
      :align="center"
      v-if="isAdmin"
    >
      <el-image
        style="width: 100px; height: 100px"
        :src="userStore.adminAvatar"
      />
    </el-descriptions-item>
    <el-descriptions-item
      :rowspan="2"
      :width="140"
      label="头像"
      :align="center"
      v-else
    >
      <el-image
        style="width: 100px; height: 100px"
        :src="userStore.readerAvatar"
      />
    </el-descriptions-item>
    <el-descriptions-item label="用户名" v-if="isAdmin">
      {{ userStore.adminName }}
    </el-descriptions-item>
    <el-descriptions-item label="用户名" v-else>
      {{ userStore.readerName }}
    </el-descriptions-item>
    <el-descriptions-item label="手机号:" v-if="isAdmin">
      {{ userStore.adminPhone }}
    </el-descriptions-item>
    <el-descriptions-item label="手机号:" v-else>
      {{ userStore.readerPhone }}
    </el-descriptions-item>
    <el-descriptions-item label="性别" v-if="isAdmin">
      {{ userStore.adminGender }}</el-descriptions-item
    >
    <el-descriptions-item label="性别" v-else>
      {{ userStore.readerGender }}</el-descriptions-item
    >
    <el-descriptions-item label="借书次数" v-if="!isAdmin">
      {{ userStore.borrowTimes }}</el-descriptions-item
    >
    <el-descriptions-item label="逾期次数" v-if="!isAdmin">
      {{ userStore.ovdTimes }}</el-descriptions-item
    >
    <el-descriptions-item label="邮箱:" v-if="!isAdmin">
      {{ userStore.email }}
    </el-descriptions-item>
    <el-descriptions-item label="身份">
      <el-tag size="large">
        {{ isAdmin ? "管理员" : "用户" }}
      </el-tag>
    </el-descriptions-item>
  </el-descriptions>
</template>

<script setup>
import { ref, computed, onMounted } from "vue";
import { useUserStore } from "@/stores/user";
import { postInitReaderAPI, getInitAdminAPI } from "@/api";
import qs from "qs";
import { ElMessage } from "element-plus";

const userStore = useUserStore();
const isAdmin = computed(() => userStore.isAdmin);

// 初始化管理员信息
const getInitAdminData = async () => {
  if (isAdmin.value) {
    try {
      const res = await getInitAdminAPI();
      userStore.setAdminInfo(res);
    } catch (err) {
      console.error(err.message);
    }
  }
};
// 初始化用户信息
const postInitReaderData = async () => {
  if (!isAdmin.value) {
    try {
      const res = await postInitReaderAPI(
        qs.stringify({ readerId: userStore.readerId })
      );
      userStore.setReaderInfo(res);
    } catch (err) {
      console.error(err.message);
    }
  }
};

onMounted(() => {
  postInitReaderData();
  getInitAdminData();
});
</script>

<style scoped lang="less">
.btn {
  text-align: center;
  margin: 30px 0 0 900px;
}
</style>
