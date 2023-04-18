<!-- 用户反馈 -->

<template>
  <div class="wrapper">
    <!-- 搜索选项 卡片视图区 -->
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
        <el-table-column prop="id" label="反馈id"></el-table-column>
        <el-table-column prop="user_name" label="反馈姓名"></el-table-column>
        <el-table-column prop="title" label="标题"></el-table-column>
        <el-table-column prop="content" label="内容"></el-table-column>
        <el-table-column prop="data" label="日期"></el-table-column>
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
      <el-dialog title="发布公告" :visible.sync="addDialogVisible" width="50%" @close="addDialogClosed">
        <!-- 内容主体区 -->
        <el-form :model="addForm" :rules="addFormRules" ref="addFormRef" label-width="80px">
          <el-form-item label="发送者" prop="sender">
            <el-input v-model="addForm.sender"></el-input>
          </el-form-item>
          <el-form-item label="内容" prop="content">
            <el-input v-model="addForm.content"></el-input>
          </el-form-item>
        </el-form>
        <!-- 底部按钮区 -->
        <span slot="footer" class="dialog-footer">
          <el-button @click="addDialogVisible = false">取 消</el-button>
          <el-button type="primary" @click="addNotification">确 定</el-button>
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
      canEdit: false,
      addForm: {
      },
      addFormRules: {
        sender: [
          {required: true, message: "请输入发送者", trigger: "blur"},
          {min: 1, message: "不能为空", trigger: "blur"}
        ], content: [
          {required: true, message: "请输入内容", trigger: "blur"},
          {min: 1, message: "不能为空", trigger: "blur"}
        ]
      },
    };
  },
  // 生命周期函数
  created() {
    // const userinfo = JSON.parse(sessionStorage.getItem("userData"));
    this.fetchData({
      // root_id: userinfo.cust_id,
      page: this.queryInfo.pagenum,
      pageSize: this.queryInfo.pagesize
    });
  },
  methods: {
        // 根据用户id删除用户
        async removeById(notificationid) {
      var _this = this;
      // 弹框询问用户是否删除数据
      const cofirmResult = await this.$confirm(
          "此操作将永久删除该用户, 是否继续?",
          "提示",
          {
            confirmButtonText: "确定",
            cancelButtonText: "取消",
            type: "warning"
          }
      ).catch(err => err);
      // 如果用户确认删除，则返回字符串 confirm
      // 如果取消删除，则返回字符串 cancel
      // console.log(cofirmResult)
      if (cofirmResult !== "confirm") {
        return this.$message({
          showClose: true,
          message: "已取消删除",
          type: "info"
        });
      }
      this.$http
          .post("http://localhost:3000/notification/delete", {id: notificationid})
          .then(function (response) {
            console.log(response.data);
            if (response.data.code === 200) {
              _this.$notify({
                title: "成功",
                message: "删除成功",
                type: "success"
              });
              window.location.reload();
            } else if (response.data.code === 400) {
              _this.$notify({
                title: "失败",
                message: "删除失败",
                type: "error"
              });
            }
          })
      console.log("确认了删除");
    },

    fetchData(params) {
      this.$http
          .get("http://localhost:3000/fankui", {params})
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

    addNotification() {
     if(this.addForm.sender === undefined || this.addForm.content === undefined){
       this.$notify({
         title: "警告",
         message: "请填写完整信息",
         type: "warning"
       });
    }else{
      this.addForm.data = new Date().toLocaleString();
      this.$http
          .post("http://localhost:3000/notification/add", this.addForm)
          .then(res => {
            console.log(res);
            if (res.data.code === 200) {
              this.$notify({
                title: "成功",
                message: "添加用户成功",
                type: "success",
                duration: 2000
              });
              this.addDialogVisible = false;
              window.location.reload();
            } else {
              this.$notify.error({
                title: "失败",
                message: "添加用户失败",
                duration: 2000
              });
            }
          });
    }
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
