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
        <el-table-column prop="insuranceName" label="保险名称"></el-table-column>
        <el-table-column prop="upperLimit" label="上限金额"></el-table-column>
        <el-table-column prop="description" label="描述"></el-table-column>
        <el-table-column prop="rate" label="赔率"></el-table-column>
        <el-table-column prop="ranges" label="范围"></el-table-column>
        <el-table-column label="操作" width="150px">
          <template slot-scope="scope">
            <!-- 查看按钮 -->
            <el-tooltip effect="dark" content="查看" placement="top" :enterable="false">
              <el-button type="success" icon="el-icon-view" size="mini" @click="rowClik(scope.row)"></el-button>
            </el-tooltip>
            <!-- 购买按钮 -->
            <el-tooltip effect="dark" content="购买" placement="top" :enterable="false">
              <el-button type="success" icon="el-icon-goods" size="mini" @click="doBuy(scope.row)"></el-button>
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
      <el-dialog
          title="填写信息"
          :visible.sync="aVisiable"
          width="50%"
          @close="aVisiable = false"
      > <!-- 内容主体 -->
        <el-form :model="editForm" ref="editFormRef" label-width="120px">
          <el-form-item label="保险员ID" prop="insuranceName">
            <el-input v-model="editForm.root_id"></el-input>
          </el-form-item>
          <el-form-item label="购买金额" prop="insuranceName">
            <el-input v-model="editForm.amount"></el-input>
          </el-form-item>
        </el-form>
        <span slot="footer" class="dialog-footer">
          <el-button @click="aVisiable = false">取 消</el-button>
          <el-button type="primary" @click="realBuy">确 定</el-button>
        </span>
      </el-dialog>
      <!-- 编辑信息的对话框 -->
      <el-dialog
          title="编辑信息"
          :visible.sync="editdialogVisible"
          width="50%"
          @close="editDialogClosed"
      >
        <!-- 内容主体 -->
        <el-form :model="editForm" ref="editFormRef" label-width="120px">
          <el-form-item label="保险名称" prop="insuranceName">
            <el-input v-model="editForm.insuranceName" :disabled="!canEdit"></el-input>
          </el-form-item>
          <el-form-item label="上限金额" prop="upperLimit">
            <el-input v-model="editForm.upperLimit" :disabled="!canEdit"></el-input>
          </el-form-item>
          <el-form-item label="描述" prop="description">
            <el-input v-model="editForm.description" :disabled="!canEdit"></el-input>
          </el-form-item>
          <el-form-item label="赔率" prop="rate">
            <el-input v-model="editForm.rate" :disabled="!canEdit"></el-input>
          </el-form-item>
          <el-form-item label="范围" prop="ranges">
            <el-input v-model="editForm.ranges" :disabled="!canEdit"></el-input>
          </el-form-item>
        </el-form>
        <span slot="footer" class="dialog-footer">
          <el-button @click="editdialogVisible = false">取 消</el-button>
          <el-button type="primary" @click="doConfirm" v-show="canEdit">确 定</el-button>
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
      aVisiable: false,
    };
  },
  // 生命周期函数
  created() {
    const userinfo = JSON.parse(sessionStorage.getItem("userData"));
    if (!userinfo) {
      this.$message({
        showClose: true,
        message: "请先登录",
        type: "error"
      });
      setTimeout(() => this.$router.push("/login"), 1500)
      return;
    }
    try {
      const userinfo = JSON.parse(sessionStorage.getItem("userData"));
      console.log(userinfo)
      if (userinfo && userinfo.role === 0) {
        this.canEdit = true;
      }
    } catch (e) {
      this.canEdit = false;
    }

    this.$http
        .get("http://localhost:3000/bxxx/list", {
          params: {
            page: this.queryInfo.pagenum,
            pageSize: this.queryInfo.pagesize
          }
        })
        .then((response) => {
          console.log(response.data);
          if (response.data.code === 200) {
            this.listData = response.data.data;
            this.total = response.data.total;
          }
        });
  },
  methods: {
    fetchData(params) {
      this.$http
          .get("http://localhost:3000/bxxx/list", {params})
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
    async realBuy() {
      if (!this.editForm.root_id || !this.editForm.amount) {
        this.$message({
          message: '请填写完整信息',
          type: 'warning'
        });
        return;
      }
      const userinfo = JSON.parse(sessionStorage.getItem("userData"));
      const cofirmResult = await this.$confirm(
          "此操作将购买该保险, 是否继续?",
          "提示",
          {
            confirmButtonText: "确定",
            cancelButtonText: "取消",
            type: "warning"
          }
      ).catch(err => err);
      if (cofirmResult !== "confirm") {
        return;
      }
      this.$http
          .post("http://localhost:3000/bxxx/buy", {
            userId: userinfo.cust_id,
            typeId: this.editForm.type_id,
            root_id: this.editForm.root_id,
            amount: this.editForm.amount,
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
              setTimeout(() => {
                window.location.reload();
              }, 1000);
            } else if (response.data.code === 201) {
              this.$notify({
                title: "失败",
                message: "购买失败, 不可重复购买",
                type: "error"
              });
            } else {
              this.$notify({
                title: "失败",
                message: "购买失败",
                type: "error"
              });
            }
          });
    },
    async doBuy(row) {
      this.editForm = row;
      this.aVisiable = true;
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
          .delete(`http://localhost:3000/bxxx/delete?typeId=${row.type_id}`)
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
.wrapper {
  width: 1080px;
  margin: 0 auto;
}
</style>
