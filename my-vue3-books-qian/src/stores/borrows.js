import { defineStore } from "pinia";
import { postBorrowsListAPI, postBorrowsAPI } from "@/api";
import { postInitReaderListAPI } from "@/api";
import { useUserStore } from "@/stores/user"; // 正确的引入方式
import { useBooksStore } from "@/stores/books"; // 正确的引入方式
import moment from "moment";
import { ref } from "vue";
import qs from "qs";

export const useBorrowsStore = defineStore(
  "borrows",
  () => {
    const userStore = useUserStore(); // 使用 userStore
    const booksStore = useBooksStore(); // 使用 booksStore

    // 管理员接收所有记录
    const borrowsList = ref([]);
    // 读者只接收自己的借阅记录
    const borrows = ref([]);

    // 管理员接收所有记录
    const postBorrowsListData = async (readerId) => {
      try {
        const res = await postBorrowsListAPI(qs.stringify(readerId));
        borrowsList.value = res.data.map((item) => {
          // 在 userStore 中查找对应的读者名字
          const reader = userStore.readerList.find(
            (reader) => reader.readerId === item.readerId
          );

          return {
            ...item,
            readerName: reader ? reader.readerName : "未知读者", // 添加读者姓名
            borrowDate: moment
              .utc(item.borrowDate)
              .format("YYYY-MM-DD HH:mm:ss"), // 格式化借阅日期
            returnDate: moment
              .utc(item.returnDate)
              .format("YYYY-MM-DD HH:mm:ss"), // 格式化应还日期
            realDate: moment.utc(item.realDate).format("YYYY-MM-DD HH:mm:ss"), // 格式化实际还书日期
          };
        });
      } catch (err) {
        console.error(err.message);
      }
    };
    // 读者接收自己的借阅记录
    const postBorrowsData = async (readerId) => {
      try {
        const res = await postBorrowsAPI(qs.stringify(readerId));
        console.log(" 读者接收自己的借阅记录", res);
        borrows.value = res.data.map((item) => {
          return {
            ...item,
            borrowDate: moment
              .utc(item.borrowDate)
              .format("YYYY-MM-DD HH:mm:ss"), // 格式化借阅日期
            returnDate: moment
              .utc(item.returnDate)
              .format("YYYY-MM-DD HH:mm:ss"), // 格式化应还日期
          };
        });
      } catch (err) {
        console.error(err.message);
      }
    };

    // 返回响应式状态和方法
    return {
      borrows,
      borrowsList,
      postBorrowsData,
      postBorrowsListData,
    };
  },
  {
    persist: true, // 持久化到 localStorage
  }
);
