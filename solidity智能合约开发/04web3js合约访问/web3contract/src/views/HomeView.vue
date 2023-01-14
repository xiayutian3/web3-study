<template>
  <div class="home">
    <button @click="sign">签名</button><br />
    <button @click="getOwner">获取owner</button><br />
    <div>
      <button @click="changeOwner">changeOwner</button>
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
    //   部署的合约地址 在 goerli测试网上  2023-1-14
    //  0x416ab7b769D82298C18630BD55347b0C98723E62

    // 账号一 0xfB04F04e64E52371fE93a7eDc2C0661e8ce5047d
    // 账号二 0xD3C2d2F307EE9d93369F34f328D7Ff7e09044d6c

    const newownerAddress = ref<any>();
    let getOwner: any;
    let changeOwner: any;
    let sign: any;

    let myaccounts: any; // 合约
    // 读取操作
    getOwner = function () {
      console.log("123456");
      const contractAddress = "0x416ab7b769D82298C18630BD55347b0C98723E62"; // 合约地址
      const ownercontract = new window.web3.eth.Contract(
        owner_abi,
        contractAddress
      ); //通过web3，合约abi构造合约对象,方便后续调用   //call web3中只读方法的调用
      ownercontract.methods.getOwner().call(function (err: any, res: any) {
        if (err) {
          console.log("An error occured", err);
        } else {
          alert("the owner is :" + res);
          return res;
        }
      });
    };

    // 写入操作
    changeOwner = function () {
      // <HTMLInputElement>
      // const newownerDom = document.getElementById(
      //   "newowner"
      // ) as HTMLInputElement | null;
      // const newowner = newownerDom?.value;

      // const newowner = newownerAddress.value;
      const contractAddress = "0x416ab7b769D82298C18630BD55347b0C98723E62"; // 合约地址
      const ZombieFactory = new window.web3.eth.Contract(
        owner_abi,
        contractAddress
      );
      const me = myaccounts[0];
      const trans = ZombieFactory.methods.changeOwner(newownerAddress.value);
      trans
        .send({ from: me })
        .on("transactionHash", function (hash: string) {
          console.log("hash: ", hash);
        })
        .on("receipt", function (receipt: any) {
          console.log("receipt: ", receipt);
        })
        .on("confirmation", function (confirmationNumber: any, receipt: any) {
          console.log("confirmationNumber: ", confirmationNumber);
        })
        .on("error", function (error: any, receipt: any) {
          console.log("error: ", error);
        });
    };

    // 签名函数
    sign = function () {
      var myDate = new Date();
      var timestamp = myDate.getTime();
      window.web3.eth.getCoinbase().then(function (coinbase: any, error: any) {
        var data = window.web3.utils.fromUtf8(timestamp + coinbase);
        data = window.web3.utils.sha3(data);
        window.web3.eth
          .sign(data, coinbase)
          .then(function (sig: any) {
            console.log("sig: ", sig);
          })
          .catch(function (err: any) {
            console.log("err: ", err);
          });
      });
    };

    onMounted(() => {
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
    });

    return {
      newownerAddress,
      getOwner,
      changeOwner,
      sign,
    };
  },
});
</script>
