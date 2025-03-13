import { defineConfig } from "vite";
import vue from "@vitejs/plugin-vue";
import path from "path"; // 确保你已经导入了 path 模块

export default defineConfig({
  plugins: [vue()],

  // Vite 默认会处理 .js, .ts, .json 等文件，如果需要处理其他文件类型，可以在这里配置
  resolve: {
    alias: {
      // 别名配置
      // 键必须以斜线开始和结束
      "@": path.resolve(__dirname, "./src"),
      components: path.resolve(__dirname, "./src/components"),
      assets: path.resolve(__dirname, "./src/assets"),
      "#": path.resolve(__dirname, "types"),
      build: path.resolve(__dirname, "build"),
    },
    extensions: [".js", ".ts", ".jsx", ".tsx", ".vue"], // 根据项目需要处理的文件类型进行配置
  },
  // Vite 内置了开发服务器和代理配置
  server: {
    host: "localhost", // 指定服务器监听的主机名
    port: 3000, // 指定服务器端口
    proxy: {
      "/api": {
        target: "http://localhost:8981", // 配置好的后端接口地址
        changeOrigin: true, // 允许跨域
        ws: true, // 支持 WebSocket
        rewrite: (path) => path.replace(/^\/api/, ""), // 重写路径
      },
    },
  },
  // 其他 Vite 配置...
});
