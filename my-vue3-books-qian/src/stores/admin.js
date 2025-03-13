// stores/admin.js
import { defineStore } from "pinia";
import { ref } from "vue";

export const useAdminStore = defineStore(
  "admin",
  () => {
    const isAdmin = ref(false);
    const adminPhone = ref("");
    const setAdminInfo = (data) => {
      isAdmin.value = true;
      adminPhone.value = data.adminPhone;
    };
    return {
      isAdmin,
      adminPhone,
      setAdminInfo,
    };
  },
  {
    persist: true, // 持久化到localStorage
  }
);
