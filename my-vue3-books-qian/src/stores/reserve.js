// stores/reserve.js
import { defineStore } from "pinia";
import { useBooksStore } from "@/stores/books";
import {
  postReserveAPI,
  postReserveListAPI,
  postCancelReserveAPI,
} from "@/api";
import qs from "qs";
import moment from "moment";
import { ref } from "vue";
const booksStore = useBooksStore();
export const useReserveStore = defineStore(
  "reserve",
  () => {
    // 管理员获取预订列表数据
    const reserveList = ref([]);
    //读者提交预订数据
    const reserve = ref([]);

    //  管理员获取预订列表数据
    const postReserveListData = async () => {
      try {
        const res = await postReserveListAPI();
        console.log(res);
        // 管理员保存预订图书记录
        reserveList.value = res.data?.map((item) => ({
          ...item,
          date: moment.utc(item.date).format("YYYY-MM-DD HH:mm:ss"),
        }));
      } catch (err) {
        console.error(err.message);
      }
    };

    // 读者提交预订数据
    const postReserveData = async (readerObj) => {
      try {
        console.log("readerObj", readerObj);
        const res = await postReserveAPI(readerObj);
        console.log("提交预订数据", res);

        // 读者保存预订图书记录
        reserve.value = res.data
          ?.filter((item) => item.readerId === readerObj.readerId)
          .map((item) => {
            const bookInfo = booksStore.booksList.find(
              (book) => book.bookId === item.bookId
            );
            return {
              ...item,
              date: moment.utc(item.date).format("YYYY-MM-DD HH:mm:ss"),
              bookName: bookInfo ? bookInfo.bookName : "未知书名",
              author: bookInfo ? bookInfo.author : "未知作者",
            };
          });
        console.log("读者reserve", reserve.value);
      } catch (err) {
        console.error(err.message);
      }
    };

    // 取消预订
    const postCancelReserveData = async (readerObj) => {
      try {
        const res = await postCancelReserveAPI(qs.stringify(readerObj));
        if (res.status === 200) {
          reserve.value = reserve.value.filter((item, idx) => idx !== index);
          reserve.value = res.data;
        }
      } catch (err) {
        console.error(err);
      }
    };

    // 返回响应式状态和方法
    return {
      reserveList,
      reserve,
      postReserveListData,
      postReserveData,
      postCancelReserveData,
    };
  },
  {
    persist: true, // 持久化到localStorage
  }
);
