<template>
  <div class="home">
    <button>获取owner</button>
    <div>
      <button>changeOwner</button>
      <input type="text" v-model="newownerAddress" />
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent, onMounted, ref } from "vue";
import { owner_abi } from "@/assets/owner";

export default defineComponent({
  name: "HomeView",
  setup() {
    const newownerAddress = ref<number>();

    onMounted(() => {
      let myaccounts: any; // 合约
      // 连接合约代码
      window.addEventListener("load", () => {
        if (!window.web3) {
          // 用来判断你是否安装了metamask钱包
          window.alert("please install metamask first");
          return;
        }
        if (window.ethereum) {
          window.ethereum
            .enable()
            .then((accounts: any) => {
              // 调用metamask的登陆界面
              myaccounts = accounts;
              window.web3 = new window.Web3(window.ethereum); // 利用metamask钱包给浏览器注入的ethereum，通过web3js重新生成 web3对象，注入到浏览器当中
            })
            .catch((error: any) => {
              console.log(error);
            });
        }
      });

      // 读取操作
      function getOwner() {
        const contractAddress = "0x4525635525255156225"; // 合约地址
        const ownercontract = new window.web3.eth.Contract(
          owner_abi,
          contractAddress
        ); //通过web3，合约abi构造合约对象,方便后续调用
        ownercontract.methods.getOwner().call(function (err: any, res: string) {
          if (err) {
            console.log("An error occured", err);
            return;
          }
          alert("the owner is :" + res);
        });
      }

      // 写入操作
      function changeOwner() {
        // <HTMLInputElement>
        const newownerDom = document.getElementById(
          "newowner"
        ) as HTMLInputElement | null;
        const newowner = newownerDom?.value;
        const contractAddress = "0x4525635525255156225"; // 合约地址
        const ZombieFactory = new window.web3.eth.Contract(
          owner_abi,
          contractAddress
        );
        const me = myaccounts[0];
        const trans = ZombieFactory.methods.changeOwner(newowner);
        trans
          .send({ from: me })
          .on("transactionHash", function (hash: string) {
            console.log("hash: ", hash);
          })
          .on("receipt", function (receipt: any) {
            console.log("receipt: ", receipt);
          });
      }
    });

    return {
      newownerAddress,
    };
  },
});
</script>
