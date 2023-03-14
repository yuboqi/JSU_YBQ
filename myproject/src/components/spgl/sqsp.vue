<template>
  <div class="bg">
    <!-- 面包屑导航区 -->
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{ path: '/home' }">首页</el-breadcrumb-item>
      <el-breadcrumb-item>后勤服务</el-breadcrumb-item>
      <el-breadcrumb-item>损耗报修</el-breadcrumb-item>
    </el-breadcrumb>
    <!-- 添加保修卡片视图区 -->
    <el-card>
      <el-form :model="formData" ref="addFormRef" label-width="80px">
        <el-row>
          <el-col :span="10">
            <!-- 索赔的时间 -->
            <el-form-item label="索赔的时间" prop="data" label-width="100px">
              <el-date-picker
                  v-model="formData.claimsDate"
                  type="date"
                  value-format="yyyy-MM-dd HH:mm:ss"
                  placeholder="请选择索赔的时间"
                  :picker-options="pickerOptions"
              ></el-date-picker>
            </el-form-item>
          </el-col>
          <el-col :span="10">
            <el-form-item label="选择保险">
              <el-select v-model="formData.policyId" placeholder="请选择保险" clearable>
                <el-option
                    v-for="item in myBx"
                    :key="item.id"
                    :label="item.insuranceName"
                    :value="item.policies_id"
                ></el-option>
              </el-select>
            </el-form-item>
          </el-col>
        </el-row>
        <!-- 报修表单 -->
        <el-row>
          <el-col :span="12">
            <el-form-item label="索赔的金额" prop="claims_money" label-width="100px">
              <el-input v-model="formData.claimsMoney" placeholder="请输入索赔的金额" clearable></el-input>
            </el-form-item>
          </el-col>
        </el-row>
        <el-form-item label="问题描述" prop="description" label-width="100px">
          <el-input
              v-model="formData.description"
              type="textarea"
              :autosize="{ minRows: 2, maxRows: 8}"
              placeholder="请描述具体索赔描述"
              clearable
          ></el-input>
        </el-form-item>
        <el-row type="flex" justify="end">
          <el-button @click="cancel">重置</el-button>
          <el-button type="primary" @click="apply">申请索赔</el-button>
        </el-row>
      </el-form>
    </el-card>
  </div>
</template>

<script>
export default {
  created() {
    const userinfo = JSON.parse(sessionStorage.getItem("userData"));
    console.log(userinfo)
    this.$http
        .get("http://localhost:3000/bxxx/myBx", {
          params: {
            userId: userinfo.cust_id
          }
        })
        .then((response) => {
          if (response.data.code === 200) {
            this.myBx = response.data.data;
          }
        });
  },
  data() {
    return {
      myBx: [],
      formData: {},
      pickerOptions: {
        disabledDate(time) {
          return time.getTime() > Date.now();
        },
        shortcuts: [
          {
            text: "今天",
            onClick(picker) {
              picker.$emit("pick", new Date());
            }
          }
        ]
      },
    };
  },
  methods: {
    // 申请
    apply() {
      console.log(this.formData);
      const userinfo = JSON.parse(sessionStorage.getItem("userData"));
      const params = {
        ...this.formData,
        custId: userinfo.cust_id
      }
      this.$http
          .post("http://localhost:3000/spgl/apply", params)
          .then((response) => {
            if (response.data.code === 200) {
              this.$message({
                showClose: true,
                message: "申请成功",
                type: "success"
              });
              this.$refs.addFormRef.resetFields();
            } else {
              this.$message({
                showClose: true,
                message: "申请失败",
                type: "error"
              });
            }
          });
    },
    // 取消按钮
    cancel() {
      this.$refs.addFormRef.resetFields();
    }
  }
};
</script>

<style lang="css" scoped>
.el-card {
  opacity: 0.8;
  margin-top: 0;
}

.el-breadcrumb {
  background: #eee;
  height: 30px;
  margin-bottom: 0;
}

.el-input,
.el-form-item {
  color: black;
}

.tishi {
  color: rgb(253, 56, 56);
  font-size: 14px;
  text-align: center;
}
</style>
