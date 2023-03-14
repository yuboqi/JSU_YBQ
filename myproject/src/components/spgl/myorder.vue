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
          </el-col><!-- 订单号 -->
          <el-col :span="8">
            <el-form-item label="订单号" label-width="100px">
              <el-input v-model="ddh" placeholder="请输入订单号" clearable></el-input>
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
        <el-table-column prop="insuranceName" label="保险名称"></el-table-column>
        <el-table-column prop="start_time" label="购买的保险时间"></el-table-column>
        <el-table-column prop="end_time" label="保险到期时间"></el-table-column>
        <el-table-column prop="insurance_cost" label="总共花费"></el-table-column>
        <el-table-column label="操作" width="150px">
          <template slot-scope="scope">
            <!-- 查看按钮 -->
            <el-tooltip effect="dark" content="查看" placement="top" :enterable="false">
              <el-button type="success" icon="el-icon-view" size="mini" @click="rowClik(scope.row)"></el-button>
            </el-tooltip>
            <!-- 删除按钮 -->
            <el-tooltip effect="dark" content="删除" placement="top" :enterable="false">
              <el-button
                  type="danger"
                  icon="el-icon-delete"
                  size="mini"
                  @click="doDelete(scope.row)"
              ></el-button>
            </el-tooltip>
          </template>
        </el-table-column>
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
      <!-- 编辑信息的对话框 -->
      <el-dialog
          title="编辑信息"
          :visible.sync="editdialogVisible"
          width="50%"
          @close="editDialogClosed"
      >
        <!-- 内容主体 -->
        <el-form :model="editForm" ref="editFormRef" label-width="120px">
          <el-form-item label="订单号" prop="number">
            <el-input v-model="editForm.number" disabled></el-input>
          </el-form-item>
          <el-form-item label="保险类别" prop="insuranceName">
            <el-input v-model="editForm.insuranceName" disabled></el-input>
          </el-form-item>
          <el-form-item label="购买的保险时间" prop="start_time">
            <el-input v-model="editForm.start_time" disabled></el-input>
          </el-form-item>
          <el-form-item label="保险到期时间" prop="end_time">
            <el-input v-model="editForm.end_time" disabled></el-input>
          </el-form-item>
          <el-form-item label="总共花费" prop="insurance_cost">
            <el-input v-model="editForm.insurance_cost" disabled></el-input>
          </el-form-item>
        </el-form>
        <span slot="footer" class="dialog-footer">
          <el-button @click="editdialogVisible = false">取 消</el-button>
          <el-button type="primary" @click="editdialogVisible = false">确 定</el-button>
        </span>
      </el-dialog>
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
      ddh: "",
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
      userinfo: {},
    };
  },
  // 生命周期函数
  created() {
    const userinfo = JSON.parse(sessionStorage.getItem("userData"));
    if (!userinfo) {
      this.$message.error("请先登录");
      setTimeout(() => {
        this.$router.push("/login");
      }, 1000);
    }
    this.userinfo = userinfo
    this.fetchData({
      userId: userinfo.cust_id,
      page: this.queryInfo.pagenum,
      pageSize: this.queryInfo.pagesize
    });
  },
  methods: {
    fetchData(params) {
      this.$http
          .get("http://localhost:3000/bxxx/myOrder", {params})
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
      this.fetchData({
        userId: this.userinfo.cust_id,
        bxmc: this.bxmc,
        ddh: this.ddh,
        page: this.queryInfo.pagenum,
        pageSize: this.queryInfo.pagesize
      });
    },
    // 监听pageSize改变的事件
    handleSizeChange(newSize) {
      this.queryInfo.pagesize = newSize;
      this.fetchData({
        userId: this.userinfo.cust_id,
        bxmc: this.bxmc,
        ddh: this.ddh,
        page: this.queryInfo.pagenum,
        pageSize: this.queryInfo.pagesize
      });
    },
    // 监听页码值改变的事件
    handleCurrentChange(newPage) {
      this.queryInfo.pagenum = newPage;
      this.fetchData({
        userId: this.userinfo.cust_id,
        bxmc: this.bxmc,
        ddh: this.ddh,
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
    async doBuy(row) {
      this.editForm = row;
      const userinfo = JSON.parse(sessionStorage.getItem("userData"));
      await this.$confirm(
          "此操作将购买该保险, 是否继续?",
          "提示",
          {
            confirmButtonText: "确定",
            cancelButtonText: "取消",
            type: "warning"
          }
      ).catch(err => err);
      this.$http
          .post("http://localhost:3000/bxxx/buy", {
            userId: userinfo.cust_id,
            typeId: this.editForm.type_id
          })
          .then((response) => {
            console.log(response.data);
            if (response.data.code === 200) {
              this.$notify({
                title: "成功",
                message: "购买成功",
                type: "success"
              });
              this.editdialogVisible = false;
              window.location.reload();
            } else {
              this.$notify({
                title: "失败",
                message: "购买失败",
                type: "error"
              });
            }
          });
    },
    doConfirm() {
      this.$refs.editFormRef.validate(valid => {
        if (!valid) return;
        this.$http
            .put("http://localhost:3000/bxxx/update", {...this.editForm, typeId: this.editForm.type_id})
            .then((response) => {
              console.log(response.data);
              if (response.data.code === 200) {
                this.$notify({
                  title: "成功",
                  message: "修改成功",
                  type: "success"
                });
                this.editdialogVisible = false;
                window.location.reload();
              } else {
                this.$notify({
                  title: "失败",
                  message: "修改失败",
                  type: "error"
                });
              }
            });
      });
    },
    // 分配学生按钮添加事件
    addStudent(sushe, sex, lyid) {
      this.addForm.sex = sex;
      this.addForm.sushe = sushe;
      this.addForm.lyid = lyid;
      this.addDialogVisible = true;
    },
    // 监听分配学生对话框的关闭事件
    addDialogClosed() {
      this.$refs.addFormRef.resetFields();
    },
    // 根据id删除对应学生信息
    async doDelete(row) {
      const cofirmResult = await this.$confirm(
          "此操作将永久删除该信息, 是否继续?",
          "提示",
          {
            confirmButtonText: "确定",
            cancelButtonText: "取消",
            type: "warning"
          }
      ).catch(err => err);
      if (cofirmResult !== "confirm") {
        return this.$message({
          showClose: true,
          message: "已取消删除",
          type: "info"
        });
      }
      // 如果点击了确认按钮则发起请求删除对应数据
      this.$http
          .delete(`http://localhost:3000/bxxx/deleteOrder?policiesId=${row.policies_id}`)
          .then((response) => {
            console.log(response.data);
            if (response.data.code === 200) {
              this.$message({
                showClose: true,
                message: "删除成功",
                type: "success"
              });
              setTimeout(() => {
                window.location.reload();
              }, 1500)
            }
          });
      console.log("确认了删除");
    },
    // 监听编辑楼宇信息对话框的关闭事件
    editDialogClosed() {
      this.$refs.editFormRef.resetFields();
    },
  }
};
</script>

<style lang="css" scoped>
.wrapper{
  width: 1080px;
  margin: 0 auto;
}
</style>
