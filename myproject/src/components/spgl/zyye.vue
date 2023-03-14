<template>
  <div class="wrapper">
    <!-- 搜索选项 卡片视图区 -->
    <el-card>
      <el-form label-width="60px">
        <el-row>
          <!-- 保险名称 -->
          <el-col :span="8">
            <el-form-item label="保险名称" label-width="100px">
              <el-input v-model="bxmc" placeholder="请输入保险名称" clearable></el-input>
            </el-form-item>
          </el-col>
          <!-- 搜索按钮 -->
          <el-col :span="6">
            <el-button type="primary" icon="el-icon-search" @click="search">搜索</el-button>
          </el-col>
        </el-row>
      </el-form>
    </el-card>
    <!-- 详细信息展示区域 -->
    <el-card>
      <el-table
          :data="listData"
          style="width: 100%"
          stripe
          border
          :row-key="getRowKeys"
          :expand-row-keys="expands"
          height="380"
      >
        <el-table-column prop="number" label="保险编号"></el-table-column>
        <el-table-column prop="insuranceName" label="保险名称"></el-table-column>
        <el-table-column prop="turnover" label="销售额"></el-table-column>
      </el-table>
      <div id="myEcharts1" style="width:100%;min-height: 300px;margin-top: 50px"/>
      <!-- 分页 -->
      <el-pagination
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
          :current-page="queryInfo.pagenum"
          :page-sizes="[1, 2, 5, 10]"
          :page-size="queryInfo.pagesize"
          layout="total, sizes, prev, pager, next, jumper"
          :total="total"
      ></el-pagination>
    </el-card>
  </div>
</template>

<script>
import createEcharts from "@/components/spgl/myEcharts";

export default {
  data() {
    return {
      listData: [],
      // 要搜索的保险名称
      bxmc: "",
      queryInfo: {
        // 当前页数
        pagenum: 1,
        // 当前页每页显示多少条数据
        pagesize: 5
      },
      // 总页数
      total: 7,
      // 要展开的行，数值的元素是row的key值
      expands: [],
      // 控制分配学生的对话框的显示与隐藏
      addDialogVisible: false,
      // 控制编辑的对话框的显示与隐藏
      editdialogVisible: false,
      // 编辑学生信息的表单数据
      editForm: {},
      canEdit: false
    };
  },
  // 生命周期函数
  created() {
    this.fetchData({
      page: this.queryInfo.pagenum,
      pageSize: this.queryInfo.pagesize
    });
  },
  methods: {
    fetchData(params) {
      this.$http
          .post("http://localhost:3000/bxpc/zyye", params)
          .then((response) => {
            if (response.data.code === 200) {
              this.listData = response.data.data;
              this.total = response.data.total;
              createEcharts("myEcharts1", "总营业额", this.listData.map(val => ({
                name: val.insuranceName,
                value: val.turnover
              })));
            } else {
              this.$notify({
                title: "警告",
                message: "抱歉，没有找到任何信息，您可以重新尝试一下",
                type: "warning"
              });
            }
          });
    },
    // 点击搜索按钮发起请求
    search() {
      this.fetchData({
        bxmc: this.bxmc,
        page: this.queryInfo.pagenum,
        pageSize: this.queryInfo.pagesize
      });
    },
    // 监听pageSize改变的事件
    handleSizeChange(newSize) {
      this.queryInfo.pagesize = newSize;
      this.fetchData({
        bxmc: this.bxmc,
        page: this.queryInfo.pagenum,
        pageSize: this.queryInfo.pagesize
      });
    },
    // 监听页码值改变的事件
    handleCurrentChange(newPage) {
      this.queryInfo.pagenum = newPage;
      this.fetchData({
        bxmc: this.bxmc,
        page: this.queryInfo.pagenum,
        pageSize: this.queryInfo.pagesize
      });
    },
    //获取row的key值
    getRowKeys(row) {
      return row.id;
    },
    rowClik(row) {
      this.editForm = row;
      this.editdialogVisible = true;
    },
    // 监听分配学生对话框的关闭事件
    addDialogClosed() {
      this.$refs.addFormRef.resetFields();
    },
    // 监听编辑楼宇信息对话框的关闭事件
    editDialogClosed() {
      this.$refs.editFormRef.resetFields();
    },
  }
};
</script>

<style lang="css" scoped>
</style>
