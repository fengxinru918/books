<template>
  <el-table
    :data="reserveList"
    style="width: 100%"
    height="660"
    :default-sort="{ prop: 'date', order: 'descending' }"
  >
    <el-table-column type="expand">
      <template #default="props">
        <el-form label-position="left" class="demo-table-expand">
          <el-form-item label="预约日期:">
            <span>{{ props.row.date }}</span>
          </el-form-item>
          <el-form-item label="图书 ID:">
            <span>{{ props.row.bookId }}</span>
          </el-form-item>
          <el-form-item label="图书名称:">
            <span>{{ props.row.bookName }}</span>
          </el-form-item>
          <el-form-item label="读者编号:">
            <span>{{ props.row.readerId }}</span>
          </el-form-item>
          <el-form-item label="读者姓名:">
            <span>{{ props.row.readerName }}</span>
          </el-form-item>
        </el-form>
      </template>
    </el-table-column>
    <el-table-column label="预约日期" sortable prop="date">
      <template #default="scope">
        <i class="el-icon-time"></i>
        <span style="margin-left: 10px">{{ scope.row.date }}</span>
      </template>
    </el-table-column>
    <el-table-column label="图书名称" sortable prop="bookName">
      <template #default="scope">
        <el-tooltip placement="top" effect="light">
          <template #content>
            <div>
              编号：{{ scope.row.bookId }}<br />名称：{{ scope.row.bookName }}
            </div>
          </template>
          <el-button>{{ scope.row.bookName }}</el-button>
        </el-tooltip>
      </template>
    </el-table-column>
    <el-table-column label="读者姓名" sortable prop="readerName">
      <template #default="scope">
        <el-tooltip placement="top" effect="light">
          <template #content>
            <div>
              编号：{{ scope.row.readerId }}<br />名称：{{
                scope.row.readerName
              }}
            </div>
          </template>
          <el-button>{{ scope.row.readerName }}</el-button>
        </el-tooltip>
      </template>
    </el-table-column>
    <el-table-column label="操作">
      <template #default="scope">
        <el-button type="danger" @click="handleDelete(scope.$index, scope.row)">
          删除记录
        </el-button>
      </template>
    </el-table-column>
  </el-table>
</template>

<script setup>
import { onMounted } from "vue";
import { useReserveStore } from "@/stores/reserve";
import { postCancelReserveAPI } from "@/api";
import qs from "qs";
import { ElMessageBox, ElMessage } from "element-plus";
const reserveStore = useReserveStore();
// 获取预约列表
const reserveList = reserveStore.reserveList;

// 删除预约记录
const handleDelete = async (index, row) => {
  ElMessageBox.confirm("确认删除该用户预约记录吗？", "温馨提示", {
    confirmButtonText: "确定",
    cancelButtonText: "取消",
    type: "warning",
  })
    .then(async () => {
      await confirmDelete(index, row);
    })
    .catch(() => {});
};
// 确认删除
const confirmDelete = async (index, row) => {
  const reserveObj = {
    readerId: row.readerId,
    bookId: row.bookId,
    date: row.date,
  };
  try {
    // 发送请求
    const res = await postCancelReserveAPI(qs.stringify(reserveObj));
    if (res.status === 200) {
      ElMessage({
        showClose: true,
        message: "删除预约记录成功！",
        type: "success",
      });
    }
    // 删除选中项
    reserveList.splice(index, 1);
    reserveStore.postReserveListData(); // 刷新预约列表
  } catch (err) {
    console.log(err.message);
  }
};

// 页面挂载时获取预约记录
onMounted(() => {
  reserveStore.postReserveListData();
});
</script>

<style lang="less" scoped></style>
