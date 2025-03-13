// stores/reader.js
import { defineStore } from "pinia";
import { ref } from "vue";
import { postInitReaderListAPI, getInitAdminAPI } from "@/api";

export const useUserStore = defineStore(
  "user",
  () => {
    const readerName = ref("");
    const readerAvatar = ref("");
    const readerGender = ref("");
    const readerId = ref("");
    const readerPhone = ref("");
    const borrowTimes = ref(0);
    const email = ref("");
    const ovdTimes = ref(0);
    const readerList = ref([]);

    const adminPhone = ref("");
    const adminName = ref("");
    const adminGender = ref("");
    const adminAvatar = ref("");
    const isAdmin = ref(false);
    const adminList = ref([]);

    const setReaderInfo = (data) => {
      isAdmin.value = false;
      readerName.value = data.readerName;
      readerId.value = data.readerId;
      readerPhone.value = data.readerPhone;
      borrowTimes.value = data.borrowTimes;
      email.value = data.email;
      ovdTimes.value = data.ovdTimes;
      readerGender.value = data.gender;
      readerAvatar.value = data.avatar;
    };

    const setAdminInfo = (data) => {
      if (Array.isArray(data) && data.length > 0) {
        const adminData = data[0]; // 获取数组中的第一个对象

        // 检查 adminData 是否存在以及字段是否存在
        if (adminData && typeof adminData === "object") {
          isAdmin.value = true;
          adminPhone.value = adminData.phone;
          adminGender.value = adminData.gender;
          adminAvatar.value = adminData.avatar;
          adminName.value = adminData.adminName;
        } else {
          console.error("Invalid adminData:", adminData);
        }
      } else {
        console.error("Invalid data:", data);
      }
    };

    const setReaderList = async () => {
      try {
        const res = await postInitReaderListAPI();
        if (res.status === 200 && Array.isArray(res.data)) {
          readerList.value = res.data;
        } else {
          console.error("API 返回的数据格式不正确:", res.data);
        }
      } catch (err) {
        console.error("加载读者列表失败:", err.message);
      }
    };

    const setAdminList = async () => {
      try {
        const res = await getInitAdminAPI();
        if (res.status === 200) {
          adminList.value = res.data;
          console.log("adminList", adminList.value);
        } else {
          console.error("API 返回的数据格式不正确:", res.data);
        }
      } catch (err) {
        console.error("加载读者列表失败:", err.message);
      }
    };

    return {
      isAdmin,
      readerName,
      readerId,
      readerPhone,
      borrowTimes,
      email,
      readerAvatar,
      readerGender,
      adminGender,
      adminAvatar,
      adminName,
      ovdTimes,
      adminPhone,
      readerList,
      setReaderInfo,
      setReaderList,
      setAdminList,
      setAdminInfo,
    };
  },
  {
    persist: true, // 持久化到localStorage
  }
);
