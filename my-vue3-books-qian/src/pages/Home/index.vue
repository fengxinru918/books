<template>
  <div class="main">
    <el-row :gutter="20">
      <el-col :span="3">
        <AdminBanner v-if="isAdmin" />
        <ReaderBanner v-else />
      </el-col>
      <el-col :span="17">
        <div class="tablemain">
          <router-view />
        </div>
      </el-col>
    </el-row>
  </div>
</template>

<script setup>
import { computed } from "vue";
import { useUserStore } from "@/stores/user";
import AdminBanner from "@/components/AdminBanner/index.vue";
import ReaderBanner from "@/components/ReaderBanner/index.vue";

const userStore = useUserStore();
const isAdmin = computed(() => userStore.isAdmin);
</script>

<style lang="less" scoped>
.tablemain {
  height: calc(100vh - 100px);
  width: calc(100vw - 330px);
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
  border: 1px solid #eee;
  border-radius: 1px 1px 1px;
  padding: 20px;
}
</style>
