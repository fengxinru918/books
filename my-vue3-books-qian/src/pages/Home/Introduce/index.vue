<template>
  <div class="home">
    <h1 class="title">
      {{ isAdmin ? userStore.adminName : userStore.readerName }} , 欢迎来到{{
        isAdmin ? "智慧云端图书管理系统" : "智慧云端借阅平台"
      }},{{ dateFormat() }}好！
    </h1>
    <motionGraph />
  </div>
</template>

<script setup>
import { computed } from "vue";
import { useUserStore } from "@/stores/user";
import motionGraph from "@/components/motionGraph/motion-graph.vue";
import { dateFormat } from "@/utils/dateFormat";
const userStore = useUserStore();
const isAdmin = computed(() => userStore.isAdmin);
</script>
<style lang="less" scoped>
.home {
  .title {
    text-align: center;
    margin-left: -90px;
    @font-face {
      font-family: "阿里妈妈刀隶体 Regular";
      font-weight: 400;
      src: url("//at.alicdn.com/wf/webfont/H2dLD4i3xAdZ/jVqfdlSjufSD.woff2")
          format("woff2"),
        url("//at.alicdn.com/wf/webfont/H2dLD4i3xAdZ/txHMjY64pc5p.woff")
          format("woff");
      font-display: swap;
    }
    font-family: 阿里妈妈刀隶体 Regular;
    font-size: 30px;
  }
}
</style>
