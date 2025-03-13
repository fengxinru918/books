import { postCommentsAPI } from "/src/api/index.js";
import moment from "moment";
import { defineStore } from "pinia";
import { ref } from "vue";

export const useCommentsStore = defineStore(
  "comments",
  () => {
    const commentsList = ref([]);
    const commentId = ref([]);
    const praise = ref(0);

    const postCommentsData = async (data) => {
      try {
        const res = await postCommentsAPI(data);
        console.log("postCommentsAPI", res);
        if (res && res.data) {
          commentsList.value = res.data
            .map((item) => ({
              ...item,
              date: moment(item?.date).format("YYYY-MM-DD HH:mm:ss"),
              praise: item.praise,
              commentId: item.commentId,
            }))
            .filter((item) => item.status === 1);
          console.log("commentsList", commentsList.value);
        } else {
          console.error("Response or response data is undefined");
        }
      } catch (error) {
        console.error("Error fetching comments:", error);
      }
    };

    return {
      commentsList,
      commentId,
      praise,
      postCommentsData,
    };
  },
  {
    persist: true, // 持久化到localStorage
  }
);
