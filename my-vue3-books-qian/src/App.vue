<script>
import { RouterView } from "vue-router";
import zhCn from "element-plus/dist/locale/zh-cn.mjs";

export default {
  name: "App",
  components: {
    RouterView,
  },
  setup() {
    return {
      locale: zhCn,
    };
  },
};
</script>

<template>
  <el-config-provider :locale="locale">
    <RouterView />
  </el-config-provider>
</template>
