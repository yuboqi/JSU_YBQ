<template>
  <div>
    <el-menu
      default-active="1"
      class="el-menu-demo"
      mode="horizontal"
      @select="handleClick"
    >
      <el-menu-item index="/profile">个人中心</el-menu-item>
      <el-menu-item index="/bxcp">购买保险</el-menu-item>
      <el-menu-item index="/wddd">我的订单</el-menu-item>
      <el-submenu index="2-4">
        <template slot="title">索赔</template>
        <el-menu-item index="/f-sqsp">申请索赔</el-menu-item>
        <el-menu-item index="/f-wdsq">我的索赔</el-menu-item>
      </el-submenu>
      <el-menu-item index="/login">退出登录</el-menu-item>
      <el-menu-item index="/home" v-show="showMenu">后台管理 </el-menu-item>
    </el-menu>

    <el-dialog
      title="填写反馈"
      :visible.sync="addDialogVisible"
      width="50%"
      @close="addDialogVisible = false"
    >
      <!-- 内容主体区 -->
      <el-form :model="addForm" ref="addFormRef" label-width="90px">
        <el-form-item label="标题" prop="title">
          <el-input v-model="addForm.title"></el-input>
        </el-form-item>
        <el-form-item label="内容" prop="content">
          <el-input v-model="addForm.content"></el-input>
        </el-form-item>
        <el-form-item label="反馈人姓名" prop="user_name">
          <el-input v-model="addForm.user_name"></el-input>
        </el-form-item>
      </el-form>
      <!-- 底部按钮区 -->
      <span slot="footer" class="dialog-footer">
        <el-button @click="addDialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="addFankui">确 定</el-button>
      </span>
    </el-dialog>
    <router-view />
    <el-row>
      <!-- 搜索按钮 -->
      <el-col :span="1">
        <el-button
          type="warning"
          @click="addDialogVisible = true"
          style="margin-top: 10px; margin-left: 150px"
          >系统反馈</el-button
        >
      </el-col>
    </el-row>
    <div></div>
  </div>
</template>
<script>
export default {
  data() {
    return {
      showMenu: false,
      addDialogVisible: false,
      addForm: {},
      listData: [],
    }
  },
  //组件创建就调用getdata方法
  created() {
    this.fetchData()
  },

  mounted() {
    const ss = sessionStorage.getItem('userData')
    if (ss) {
      JSON.parse(ss).role === 0 || JSON.parse(ss).role === 1
        ? (this.showMenu = true)
        : (this.showMenu = false)
    }
  },
  methods: {
    handleClick(key) {
      window.location.href = key
    },
    addFankui() {
      if (
        this.addForm.title === undefined ||
        this.addForm.content === undefined ||
        this.addForm.user_name === undefined
      ) {
        this.$notify({
          title: '警告',
          message: '请填写完整信息',
          type: 'warning',
        })
      } else {
        this.addForm.data = new Date().toLocaleString()
        this.$http
          .post('http://localhost:3000/fankui', this.addForm)
          .then((res) => {
            console.log(res)
            if (res.data.code === 200) {
              this.$notify({
                title: '成功',
                message: '添加用户成功',
                type: 'success',
                duration: 2000,
              })
              this.addDialogVisible = false
              window.location.reload()
            } else {
              this.$notify.error({
                title: '失败',
                message: '添加用户失败',
                duration: 2000,
              })
            }
          })
      }
    },

    fetchData(params) {
      this.$http
        .get('http://localhost:3000/notification', { params })
        .then((response) => {
          if (response.data.code === 200) {
            this.$notify({
              title: '最新公告',
              message: response.data.data[0].content,
              duration: 0,
            })
          } else {
            this.$notify({
              title: '警告',
              message: '抱歉，没有找到任何信息，您可以重新尝试一下',
              type: 'warning',
            })
          }
        })
    },
  },
}
</script>

<style scoped>
/* .announcement-wrapper {
  position: fixed;
  bottom: 0;
  left: 0;
  width: 300px;
  height: 80px;
  z-index: 9999;
}
.announcement-custom-class {
  background-color: #f5f5f5;
  color: #333;
  border: none;
  box-shadow: none;
  border-radius: 0;
  padding: 10px;
} */
</style>
