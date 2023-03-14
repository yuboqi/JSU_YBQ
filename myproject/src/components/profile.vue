<template>
  <div class="wrapper">
    <el-card>
      <el-form label-width="60px">
        <el-row>
          <el-col :span="8">
            <el-form-item label="用户ID" label-width="100px">
              <el-input v-model="user.cust_id" placeholder="请输入用户名" disabled></el-input>
            </el-form-item>
          </el-col>
          <el-col :span="8">
            <el-form-item label="用户名" label-width="100px">
              <el-input v-model="user.cust_account" placeholder="请输入用户名" disabled></el-input>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="8">
            <el-form-item label="姓名" label-width="100px">
              <el-input v-model="user.cust_name" placeholder="请输入姓名" clearable></el-input>
            </el-form-item>
          </el-col>
          <el-col :span="8">
            <el-form-item label="性别" label-width="100px">
              <el-input v-model="user.cust_sex" placeholder="请输入性别" clearable></el-input>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="8">
            <el-form-item label="生日" label-width="100px">
              <el-input v-model="user.cust_birthday" placeholder="请输入生日" clearable></el-input>
            </el-form-item>
          </el-col>
          <el-col :span="8">
            <el-form-item label="地址" label-width="100px">
              <el-input v-model="user.cust_address" placeholder="请输入地址" clearable></el-input>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="8">
            <el-form-item label="邮箱" label-width="100px">
              <el-input v-model="user.cust_email" placeholder="请输入邮箱" clearable></el-input>
            </el-form-item>
          </el-col>
          <el-col :span="8">
            <el-form-item label="手机" label-width="100px">
              <el-input v-model="user.cust_phone" placeholder="请输入手机" clearable></el-input>
            </el-form-item>
          </el-col>
        </el-row>
      </el-form>
      <div class="btn-wrapper">
        <el-button type="success" icon="el-icon-view" size="mini" @click="doSave">保存</el-button>
      </div>
    </el-card>
  </div>
</template>
<script>
export default {
  data() {
    return {
      user: {}
    }
  },
  created() {
    const userinfo = JSON.parse(sessionStorage.getItem("userData"));
    if (!userinfo) {
      this.$message.error("请先登录");
      setTimeout(() => {
        this.$router.push("/login");
      }, 1000);
    }
    this.user = userinfo;
  },
  methods: {
    doSave() {
      const params = {
        ...this.user
      }
      this.$http.post("http://localhost:3000/user/update", params).then((response) => {
        if (response.data.code === 200) {
          this.getUserInfo();
          this.$message.success("保存成功");
        } else {
          this.$message.error("保存失败");
        }
      });
    },
    getUserInfo() {
      const userinfo = JSON.parse(sessionStorage.getItem("userData"));
      this.$http.get(`http://localhost:3000/user/info?custId=${userinfo.cust_id}`).then((response) => {
        if (response.data.code === 200) {
          this.user = response.data.data[0];
          sessionStorage.setItem("userData", JSON.stringify(this.user));
        } else {
          this.$message.error("获取用户信息失败");
        }
      });
    }
  }
}
</script>

<style lang="css" scoped>
.wrapper {
  width: 1080px;
  margin: 0 auto;
}

.btn-wrapper {
  text-align: right;
}
</style>
