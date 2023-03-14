<template>
  <div class="wrapper">
    <!-- 搜索选项 卡片视图区 -->
    <el-card>
      <el-form label-width="60px">
        <el-row>
          <!-- 订单号 -->
          <el-col :span="8">
            <el-form-item label="订单号" label-width="100px">
              <el-input v-model="number" placeholder="请输入订单号" clearable style="width: 200px"></el-input>
            </el-form-item>
          </el-col>
          <!-- 客户名称 -->
          <el-col :span="8">
            <el-form-item label="客户名称" label-width="100px">
              <el-input v-model="khmc" placeholder="请输入客户名称" clearable style="width: 200px"></el-input>
            </el-form-item>
          </el-col>
          <!-- 保险名称 -->
          <el-col :span="8">
            <el-form-item label="保险名称" label-width="100px">
              <el-input v-model="bxmc" placeholder="请输入保险名称" clearable style="width: 200px"></el-input>
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
        <el-table-column prop="number" label="订单号"></el-table-column>
        <el-table-column prop="cust_name" label="客户姓名"></el-table-column>
        <el-table-column prop="cust_phone" label="客户电话"></el-table-column>
        <el-table-column prop="number" label="保险编号"></el-table-column>
        <el-table-column prop="insuranceName" label="保险名称"></el-table-column>
        <el-table-column prop="rate" label="赔率"></el-table-column>
        <el-table-column prop="end_time" label="到期时间"></el-table-column>
        <el-table-column prop="description" label="描述"></el-table-column>
      </el-table>
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
export default {
  data() {
    return {
      listData: [],
      // 要搜索的保险名称
      bxmc: "",
      khmc: "",
      number: "",
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
    const userinfo = JSON.parse(sessionStorage.getItem("userData"));
    this.fetchData({
      root_id: userinfo.cust_id,
      page: this.queryInfo.pagenum,
      pageSize: this.queryInfo.pagesize
    });
  },
  methods: {
    fetchData(params) {
      this.$http
          .get("http://localhost:3000/userlist/user", {params})
          .then((response) => {
            if (response.data.code === 200) {
              this.listData = response.data.data;
              this.total = response.data.total;
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
      const userinfo = JSON.parse(sessionStorage.getItem("userData"));
      this.fetchData({
        root_id: userinfo.cust_id,
        bxmc: this.bxmc,
        khmc: this.khmc,
        number: this.number,
        page: this.queryInfo.pagenum,
        pageSize: this.queryInfo.pagesize
      });
    },
    // 监听pageSize改变的事件
    handleSizeChange(newSize) {
      const userinfo = JSON.parse(sessionStorage.getItem("userData"));
      this.queryInfo.pagesize = newSize;
      this.fetchData({
        root_id: userinfo.cust_id,
        bxmc: this.bxmc,
        khmc: this.khmc,
        number: this.number,
        page: this.queryInfo.pagenum,
        pageSize: this.queryInfo.pagesize
      });
    },
    // 监听页码值改变的事件
    handleCurrentChange(newPage) {
      const userinfo = JSON.parse(sessionStorage.getItem("userData"));
      this.queryInfo.pagenum = newPage;
      this.fetchData({
        root_id: userinfo.cust_id,
        bxmc: this.bxmc,
        khmc: this.khmc,
        number: this.number,
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
