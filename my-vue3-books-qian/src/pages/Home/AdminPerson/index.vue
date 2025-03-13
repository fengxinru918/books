<template>
  <el-table
    :data="readerList"
    style="width: 100%"
    :default-sort="{ prop: 'readerName', order: 'descending' }"
  >
    <el-table-column prop="readerName" label="姓名" sortable width="180">
    </el-table-column>
    <el-table-column prop="phone" sortable label="电话"> </el-table-column>
    <el-table-column prop="email" sortable label="邮箱"> </el-table-column>
    <el-table-column prop="borrowTimes" sortable label="借阅次数">
    </el-table-column>
    <el-table-column prop="ovdTimes" sortable label="逾期次数">
    </el-table-column>
    <el-table-column label="操作">
      <template #default="scope">
        <el-button type="primary" @click="delPerson(scope.row)"
          >删除人员</el-button
        >
      </template>
    </el-table-column>
  </el-table>
</template>

<script setup>
import { ref, onMounted } from "vue";
import { useUserStore } from "@/stores/user";
import { postDelPersonAPI, postInitReaderListAPI } from "@/api";
import { ElMessageBox, ElMessage } from "element-plus";
import qs from "qs";
const userStore = useUserStore();
const readerList = ref([]);
// 从 useReaderStore  中获取 readerList 数据
const getReaderList = () => {
  readerList.value = userStore.readerList;
};

// 删除人员
const delPerson = async (row) => {
  ElMessageBox.confirm("确认删除该人员吗？", "温馨提示", {
    confirmButtonText: "确定",
    cancelButtonText: "取消",
    type: "warning",
  })
    .then(async () => {
      await confirmDelPerson(row);
    })
    .catch(() => {});
};

// 确认删除人员
const confirmDelPerson = async (row) => {
  console.log(row);
  const infoObj = { readerId: row.readerId };
  const res = await postDelPersonAPI(qs.stringify(infoObj));
  console.log(res);
  if (res.status == 200) {
    // 从列表中移除被删除的项
    readerList.value = readerList.value.filter(
      (item) => item.readerId !== row.readerId
    );
    ElMessage({
      showClose: true,
      message: "删除人员成功！",
      type: "success",
    });
    postInitReaderListAPI(); // 更新 readerList 数据
  }
};

// 从接口中获取ReaderList数据
const postInitReaderListData = async () => {
  const res = await postInitReaderListAPI();
  userStore.setReaderList(res.data);
  getReaderList();
};

// 初始化 readerList 数据
onMounted(() => {
  postInitReaderListData();
});
</script>

<style lang="less" scoped></style>
