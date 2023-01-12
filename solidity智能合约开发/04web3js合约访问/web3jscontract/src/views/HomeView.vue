<template>
  <div class="home">

  </div>
</template>

<script lang="ts">
import { defineComponent, onMounted } from 'vue'

export default defineComponent({
  name: 'HomeView',
  setup() {
    onMounted(() => {
      let myaccounts: any // 合约
      // 连接合约代码
      window.addEventListener('load', () => {
        if (!window.web3) { // 用来判断你是否安装了metamask钱包
          window.alert('please install metamask first')
          return
        }
        if (window.ethereum) {
          window.ethereum.enable().then((accounts: any) => { // 调用metamask的登陆界面
            myaccounts = accounts
            window.web3 = new window.Web3(window.ethereum) // 利用metamask钱包给浏览器注入的ethereum，通过web3js重新生成 web3对象，注入到浏览器当中
          }).catch((error: any) => {
            console.log(error)
          })
        }
      })

      // 读取操作
      function getOwner() {
        const contractAddress = '0x4525635525255156225' // 合约地址
        const ZombieFactory = new window.web3.eth.Contract('owner_abi', contractAddress)
        ZombieFactory.methods.getOwner().call(function (err: any, res: string) {
          if (err) {
            console.log('An error occured', err)
            return
          }
          alert('the owner is :' + res)
        })
      }
      var sdf = {
        es:456
      }

      // 写入操作
      function changeOwner() {
        const newowner = (<HTMLInputElement>document.getElementById('newowner')).value
        const contractAddress = '0x4525635525255156225' // 合约地址

        const ZombieFactory = new window.web3.eth.Contract('owner_abi', contractAddress)
        const me = myaccounts[0]
        const trans = ZombieFactory.methods.changeOwner(newowner);
        // { from: me }
        trans.send(sdf).on('transactionHash', function (hash: string) {
          console.log('hash: ', hash)
        }).on('receipt', function (receipt: any) {
          console.log('receipt: ', receipt)
        })
      }

    })
  }
})
</script>
