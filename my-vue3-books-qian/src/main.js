import { createApp } from "vue";
import App from "./App.vue";
import router from "@/router";
import piniaPluginPersistedstate from "pinia-plugin-persistedstate";

import ElementPlus from "element-plus";
import "element-plus/dist/index.css";
import timeFormater from "time-formater";
import { createPinia } from "pinia";
const app = createApp(App);
// 注册持久化插件
const pinia = createPinia();
pinia.use(piniaPluginPersistedstate);
app.use(pinia);
app.use(router);
app.use(ElementPlus);

app.config.globalProperties.$moment = timeFormater;

app.mount("#app");
