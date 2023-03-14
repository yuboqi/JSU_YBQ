<template>
  <div class="wrapper">
    <!-- 搜索选项 卡片视图区 -->
    <el-card>
      <el-form label-width="60px">
        <el-row>
          <!-- 订单号 -->
          <el-col :span="8">
            <el-form-item label="订单号" label-width="100px">
              <el-input v-model="ddh" placeholder="请输入订单号" clearable></el-input>
            </el-form-item>
          </el-col>
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
        <el-table-column prop="claimsNumber" label="索赔号"></el-table-column>
        <el-table-column prop="number" label="订单号"></el-table-column>
        <el-table-column prop="custName" label="客户姓名"></el-table-column>
        <el-table-column prop="insuranceName" label="保险名称"></el-table-column>
        <el-table-column prop="claimsDate" label="购买的保险时间"></el-table-column>
        <el-table-column prop="claimsMoney" label="申请金额"></el-table-column>
        <el-table-column prop="lipeiMoney" label="理赔金额"></el-table-column>
        <el-table-column prop="claimsStatus" label="当前状态"></el-table-column>
        <el-table-column prop="description" label="描述"></el-table-column>
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
          <el-form-item label="索赔号" prop="claimsNumber">
            <el-input v-model="editForm.claimsNumber" disabled></el-input>
          </el-form-item>
          <el-form-item label="订单号" prop="number">
            <el-input v-model="editForm.number" disabled></el-input>
          </el-form-item>
          <el-form-item label="客户姓名" prop="custName">
            <el-input v-model="editForm.custName" disabled></el-input>
          </el-form-item>
          <el-form-item label="保险类别" prop="insuranceName">
            <el-input v-model="editForm.insuranceName" disabled></el-input>
          </el-form-item>
          <el-form-item label="购买的保险时间" prop="claimsDate">
            <el-input v-model="editForm.claimsDate" disabled></el-input>
          </el-form-item>
          <el-form-item label="申请金额" prop="claimsMoney">
            <el-input v-model="editForm.claimsMoney" disabled></el-input>
          </el-form-item>
          <el-form-item label="理赔金额" prop="lipeiMoney">
            <el-input v-model="editForm.lipeiMoney" disabled></el-input>
          </el-form-item>
          <el-form-item label="当前状态" prop="claimsStatus">
            <el-input v-model="editForm.claimsStatus" disabled></el-input>
          </el-form-item>
          <el-form-item label="描述" prop="description">
            <el-input v-model="editForm.description" disabled></el-input>
          </el-form-item>
        </el-form>
        <span slot="footer" class="dialog-footer">
          <el-button @click="editdialogVisible = false">取 消</el-button>
          <el-button type="primary" @click="doAudit(true)"
                     v-show="editForm.claimsStatus === '待审核' && canClick">审核通过</el-button>
          <el-button type="primary" @click="doAudit(false)"
                     v-show="editForm.claimsStatus === '待审核' && canClick">审核不通过</el-button>
          <el-button type="primary" @click="lipeiDialogVisible = true"
                     v-show="(editForm.claimsStatus === '待审核' || editForm.claimsStatus === '已通过') && canClick">进行理赔</el-button>
        </span>
      </el-dialog>
      <el-dialog
          title="理赔"
          :visible.sync="lipeiDialogVisible"
          width="50%"
          @close="lipeiDialogVisible = false"
      >
        <el-form :model="editForm" ref="editFormRef" label-width="120px">
          <el-form-item label="赔偿金额" prop="claimsNumber">
            <el-input v-model="editForm.lipeiAmount"></el-input>
          </el-form-item>
        </el-form>
        <span slot="footer" class="dialog-footer">
          <el-button @click="lipeiDialogVisible = false">取 消</el-button>
          <el-button type="primary" @click="doLipei">确 定</el-button>
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
      lipeiDialogVisible: false,
      // 编辑学生信息的表单数据
      editForm: {},
      canClick: false,
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
    this.canClick = userinfo.role === 1;
    this.fetchData({
      userId: userinfo.cust_id,
      role: userinfo.role,
      page: this.queryInfo.pagenum,
      pageSize: this.queryInfo.pagesize
    });
  },
  methods: {
    fetchData(params) {
      this.$http
          .get("http://localhost:3000/spgl/myClaims", {
            params: params
          })
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
        userId: userinfo.cust_id,
        role: userinfo.role,
        bxmc: this.bxmc || '',
        ddh: this.ddh || '',
        page: this.queryInfo.pagenum,
        pageSize: this.queryInfo.pagesize
      });
    },
    // 监听pageSize改变的事件
    handleSizeChange(newSize) {
      const userinfo = JSON.parse(sessionStorage.getItem("userData"));
      this.queryInfo.pagesize = newSize;
      this.fetchData({
        userId: userinfo.cust_id,
        role: userinfo.role,
        bxmc: this.bxmc,
        ddh: this.ddh || '',
        page: this.queryInfo.pagenum,
        pageSize: this.queryInfo.pagesize
      });
    },
    // 监听页码值改变的事件
    handleCurrentChange(newPage) {
      const userinfo = JSON.parse(sessionStorage.getItem("userData"));
      this.queryInfo.pagenum = newPage;
      this.fetchData({
        userId: userinfo.cust_id,
        role: userinfo.role,
        bxmc: this.bxmc,
        ddh: this.ddh || '',
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
          .delete(`http://localhost:3000/spgl/delete?claimsId=${row.claimsId}`)
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
    async doLipei() {
      await this.$confirm(
          "是否确认理赔",
          "提示",
          {
            confirmButtonText: "确定",
            cancelButtonText: "取消",
            type: "warning"
          }
      ).catch(err => err);
      // 得到赔率
      const rete = this.listData.find(item => item.claimsId === this.editForm.claimsId).rate;
      // 订单号
      const policiesId = this.listData.find(item => item.claimsId === this.editForm.claimsId).policiesId;
      if (this.editForm.lipeiAmount > this.editForm.insuranceCost * rete) {
        return this.$message({
          showClose: true,
          message: "理赔金额不能大于保险金额",
          type: "info"
        });
      }
      const userinfo = JSON.parse(sessionStorage.getItem("userData"));
      this.$http
          .post("http://localhost:3000/lipei", {
            claimsId: this.editForm.claimsId,
            rootId: userinfo.cust_id,
            number: policiesId, // 理赔单号,
            lipeiMoney: this.editForm.lipeiAmount, // 理赔金额
          })
          .then((response) => {
            console.log(response.data);
            if (response.data.code === 200) {
              this.$notify({
                title: "成功",
                message: "理赔成功",
                type: "success"
              });
              this.editdialogVisible = false;
              window.location.reload();
            } else {
              this.$notify({
                title: "失败",
                message: "理赔失败",
                type: "error"
              });
            }
          });
      this.lipeiDialogVisible = false;
    },
    //  审核
    async doAudit(status) {
      await this.$confirm(
          "是否确认审核",
          "提示",
          {
            confirmButtonText: "确定",
            cancelButtonText: "取消",
            type: "warning"
          }
      ).catch(err => err);
      const type = status ? "agree" : "refuse";
      this.$http
          .post("http://localhost:3000/spgl/" + type, {
            claimsId: this.editForm.claimsId
          })
          .then((response) => {
            console.log(response.data);
            if (response.data.code === 200) {
              this.$notify({
                title: "成功",
                message: "审核成功",
                type: "success"
              });
              this.editdialogVisible = false;
              window.location.reload();
            } else {
              this.$notify({
                title: "失败",
                message: "审核失败",
                type: "error"
              });
            }
          });
    }
  }
};
</script>

<style lang="css" scoped>
.el-button {
  margin-left: 30px;
}

.wrapper {
  width: 1080px;
  margin: 0 auto;
}
</style>
