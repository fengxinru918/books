// books.js
import { defineStore } from "pinia";
import { postBooksAPI } from "@/api";
import { ref } from "vue";
export const useBooksStore = defineStore(
  "books",
  () => {
    // 响应式状态
    const booksList = ref([]);
    // 初始化书籍列表的方法
    const postBooksData = async () => {
      try {
        const res = await postBooksAPI();
   
        booksList.value = res.data;
        console.log("图书列表", booksList.value);
        
      } catch (err) {
        console.error(err.message);
      }
    };

    // 返回响应式状态和方法
    return {
      booksList,
      postBooksData,
    };
  },
  {
    persist: true, // 持久化到localStorage
  }
);
