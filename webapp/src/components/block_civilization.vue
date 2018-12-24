<template>
  <div>
    <el-container v-if="tableVisible">
      <el-header>
          <span>区块-文明</span>
       <span>{{ '欢迎： ' + userAddress + '      余额：' + userBalance}}</span>
      </el-header>
      <el-container>
        <el-main>
					<el-container
					>
					<!-- <span>合约部署者控制台</span> -->
<!-- 					<el-button
						v-if="isOwner"
						type="primary"
					>设置氪金费用</el-button> -->
					<el-button
						v-if="isOwner"
						type="primary"
					>收取玩家氪金</el-button>
					<!-- </el-container>
					<el-container
						v-if="true"
					> -->
<!-- 					<span>玩家控制台</span> -->
					<el-button
						type="primary"
						@click="createFirstCityPrepare"
					>创建第一座城市</el-button>
					<el-button
						type="primary"
						@click="expansionPrepare"
					>扩张</el-button>
					<el-button
						type="primary"
						@click="attackPrepare"
					>进攻</el-button>
					<el-button
						type="primary"
						@click="mergePrepare"
					>合并城市</el-button>
					<el-button
						type="primary"
						@click="levelUpPrepare"
					>氪金升级</el-button>
<!-- 					<el-button
						v-if="true"
						type="primary"
						@click="transCityPrepare"
					>转让城市</el-button> -->
					<el-button
						type="primary"
						@click="changeNamePrepare"
					>城市改名</el-button>
					</el-container>
          <el-table
            :data="citiesArray"
            v-loading="loadCities"
          >
            <el-table-column prop="index" label="编号">
              <template slot-scope="scope">
                <span>{{ scope.row.index }}</span>
              </template>
            </el-table-column>
            <el-table-column prop="owner" label="拥有者">
              <template slot-scope="scope">
                <span>{{ scope.row.owner }}</span>
              </template>
            </el-table-column>
            <el-table-column prop="cityName" label="名字">
              <template slot-scope="scope">
                <span>{{ scope.row.cityName }}</span>
              </template>
            </el-table-column>
            <el-table-column prop="popu" label="人口">
              <template slot-scope="scope">
                <span>{{ scope.row.popu}}</span>
              </template>
            </el-table-column>
            <el-table-column prop="poli" label="政治">
              <template slot-scope="scope">
                <span>{{ scope.row.poli }}</span>
              </template>
            </el-table-column>
						<el-table-column prop="ecno" label="经济">
							<template slot-scope="scope">
								<span>{{ scope.row.ecno }}</span>
							</template>
						</el-table-column>
						<el-table-column prop="muti" label="军事">
							<template slot-scope="scope">
								<span>{{ scope.row.muti }}</span>
							</template>
						</el-table-column>
            <el-table-column prop="coldDown" label="冷却时间">
              <template slot-scope="scope">
                <span>{{ scope.row.coldDown | formatTime }}</span>
              </template>
            </el-table-column>
          </el-table>
        </el-main>
      </el-container>
    </el-container>
    <el-dialog
			:show-close="true"
			:center="false"
      :title="status"
      :visible.sync="dialogVisible"
    >
      </el-input>

      <el-input
        v-if="status=='扩张'"
        v-model="inputContent"
        :placeholder="'请输入进行扩张的城市编号'"
      ></el-input>
			
			<el-input
				v-if="status=='扩张'"
				v-model="inputContent2"
				:placeholder="'若扩张成功，城市的名称'"
			></el-input>
			
			<el-input
				v-if="status=='创建第一座城市'"
				v-model="inputContent"
				:placeholder="'请输入城市名称'"
			></el-input>
			
			<el-input
				v-if="status=='进攻'"
				v-model="inputContent"
				:placeholder="'我方城市编号'"
			></el-input>
			
			<el-input
				v-if="status=='进攻'"
				v-model="inputContent2"
				:placeholder="'敌方城市编号'"
			></el-input>
			
			<el-input
				v-if="status=='合并城市'"
				v-model="inputContent"
				:placeholder="'优先发展城市编号'"
			></el-input>
			
			<el-input
				v-if="status=='合并城市'"
				v-model="inputContent2"
				:placeholder="'以后再发展城市编号'"
			></el-input>
			
			<el-input
				v-if="status=='氪金升级'"
				v-model="inputContent"
				:placeholder="'要升级的城市'"
			></el-input>
			
			<el-input
				v-if="status=='氪金升级'"
				v-model="inputContent2"
				:placeholder="'花多少钱'"
			></el-input>
			
			<el-input
				v-if="status=='城市改名'"
				v-model="inputContent"
				:placeholder="'要改名的城市编号'"
			></el-input>
			
			<el-input
				v-if="status=='城市改名'"
				v-model="inputContent2"
				:placeholder="'新名称'"
			></el-input>
			

      <span slot="footer">
        <el-button
          v-if="status=='扩张'"
          type="primary"
          :loading="waitingConfirmButton"
          @click="expansionConfirm"
        >确定</el-button>
				
				<el-button
					v-if="status=='创建第一座城市'"
					type="primary"
					:loading="waitingConfirmButton"
					@click="createFirstCityConfirm"
				>确定</el-button>
				
				<el-button
					v-if="status=='进攻'"
					type="primary"
					:loading="waitingConfirmButton"
					@click="attackConfirm"
				>确定</el-button>
				
				<el-button
					v-if="status=='合并城市'"
					type="primary"
					:loading="waitingConfirmButton"
					@click="mergeConfirm"
				>确定</el-button>
				
				<el-button
					v-if="status=='氪金升级'"
					type="primary"
					:loading="waitingConfirmButton"
					@click="levelUpConfirm"
				>确定</el-button>
				
				<!-- <el-button
					v-if="status=='转让城市'"
					type="primary"
					:loading="waitingConfirmButton"
					@click="transCityCityConfirm"
				>确定</el-button> -->
				
				<el-button
					v-if="status=='城市改名'"
					type="primary"
					:loading="waitingConfirmButton"
					@click="changeNameConfirm"
				>确定</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
import Web3 from "web3";
import web3Admin from "web3admin";
import { nodeInfo, contractInterface, contractAddress } from "../../config";
import { formatTime } from "../../build/my-utils";

export default {
  name: "block_civilization",

  created: async function() {
    // 连接 rpc
    await this.connect();
    // 连接各节点
    nodeInfo.forEach(item => this.web3.admin.addPeer(item));
    this.contract();
		await this.realTimeUpdateCities();
  },

  data() {
    return {
      dialogVisible: false,
      tableVisible: false,
      inputContent: "",
			inputContent2: "",
      waitingConfirmButton: false,
      loadCities: false,
      citiesArray: [],
      status: "",
			sevent : null, 
			fevent : null,
			userAddress : "",
			isOwner : false,
			userBalance : -1
    };
  },

  filters: {
    formatTime
  },

  methods: {
    connect: async function() {
      return new Promise((resolve, _) => {
        this.$prompt("", "连接到节点", {
          showCancelButton: false,
          closeOnClickModal: false,
          closeOnPressEscape: false,
          showClose: false,
          modal: false,
          inputPlaceholder: "请输入rpc端口",
          beforeClose: (_, instance, done) => {
            instance.waitingConfirmButton = true;
            this.web3 = new Web3(
              new Web3.providers.HttpProvider(
                "http://127.0.0.1:" + instance.inputValue
              )
            );
            if (this.web3.isConnected()) {
              web3Admin.extend(this.web3);
              this.$message({
                type: "success",
                message: "成功连接"
              });
              instance.waitingConfirmButton = false;
							this.userAddress = this.web3.eth.accounts[0];
							this.userBalance = this.web3.eth.getBalance(this.web3.eth.accounts[0]);
							this.tableVisible = true;
              done();
            } else {
              this.$message.error("失败");
              instance.waitingConfirmButton = false;
            }
          }
        }).then(() => {
          resolve();
        });
      });
    },


    contract() {
      var that = this;
      this.contractInstance = this.web3.eth
        .contract(contractInterface)
        .at(contractAddress);
// 			console.log(this.contractInstance.owner);
// 			console.log(this.web3.eth.accounts[0]);
			this.isOwner = this.contractInstance.owner() == this.web3.eth.accounts[0];
    },

		update(){
			// fetch
			this.loadCities = true;
			var citiesNum = this.contractInstance.getCitiesNum();
			for (var i = 0; i < citiesNum; i++) {
				var citiesMessage = this.contractInstance.getCityDetails(i);
				this.citiesArray.unshift({
					index: i,
					owner: citiesMessage[0].toString(),
					cityName: citiesMessage[1],
					popu: citiesMessage[2].toString(),
					poli: citiesMessage[3].toString(),
					ecno: citiesMessage[4].toString(),
					muti: citiesMessage[5].toString(),
					coldDown: citiesMessage[6]
					
				});
			}
			this.loadCities = false;
		},

    realTimeUpdateCities() {
      this.update();
			var that = this;
      //watching
      this.contractInstance.StatusChange().watch(function(err, result) {
        if (!err) {
          that.loadCities = true;
					that.citiesArray = [];
					var citiesNum = that.contractInstance.getCitiesNum();
					for (var i = 0; i < citiesNum; i++) {
						var citiesMessage = that.contractInstance.getCityDetails(i);
						that.citiesArray.unshift({
							index: i,
							owner: citiesMessage[0].toString(),
							cityName: citiesMessage[1],
							popu: citiesMessage[2].toString(),
							poli: citiesMessage[3].toString(),
							ecno: citiesMessage[4].toString(),
							muti: citiesMessage[5].toString(),
							coldDown: citiesMessage[6]
						});
					}	
          that.loadCities = false;
        }
      });
			
      this.contractInstance.GrowCity().watch(function(err, result) {
        if (!err) {
					that.$notify({
						title: "城市发展",
						message: "编号" + result.args.index.toString() + "城市发展了"
					});
        }
      });
			
			this.contractInstance.NewCity().watch(function(err, result) {
				if (!err) {
					that.$notify({
						title: "城市建立",
						message: "编号" + result.args.index.toString() + "城市建立了",
						position: "top-left"
					});
				}
			});
			
			this.contractInstance.WeakenCity().watch(function(err, result) {
				if (!err) {
					console.log(result.args.index.toString());
					that.$notify({
						title: "城市削弱",
						message: "编号" + result.args.index.toString() + "城市被削弱了",
						type: 'warning'
					});
				}
			});
    },

    unlockAccount: async function() {
      var that = this;
      return new Promise((resolve, _) => {
        this.$prompt("请输入密码", "解锁节点账户", {
          inputType: "password",
          confirmButtonText: "确定",
          showCancelButton: false,
          closeOnClickModal: false,
          closeOnPressEscape: false,
          showClose: false,
          beforeClose: (_, instance, done) => {
            instance.waitingConfirmButton = true;
            this.web3.personal.unlockAccount(
              this.web3.eth.accounts[0],
              instance.inputValue,
              function(err, _) {
                if (err) {
                  that.$message.error("密码错误");
                  instance.waitingConfirmButton = false;
                } else {
                  that.$message({
                    type: "success",
                    message: "解锁成功"
                  });
                  instance.waitingConfirmButton = false;
                  done();
                }
              }
            );
          }
        }).then(() => {
          resolve();
        });
      });
    },

    submitTransaction: async function(successEvent, failEvent, transactionHash) {
      var that = this;
      return new Promise((resolve, _) => {
				if(that.sevent != null){
					that.sevent.stopWatching();
					that.fevent.stopWatching();
				}
        that.sevent = this.contractInstance[successEvent]();
				that.fevent = this.contractInstance[failEvent]();
        that.sevent.watch(function(err, result) {
          if (!err && result.transactionHash == transactionHash) {
            that.web3.miner.stop();
//             that.$message({
//               type: "success",
//               message: "交易完成"
//             });
            that.sevent.stopWatching();
						// that.fevent.stopWatching();
						// fetch
						that.loadCities = true;
						that.citiesArray = [];
						var citiesNum = that.contractInstance.getCitiesNum();
						for (var i = 0; i < citiesNum; i++) {
							var citiesMessage = that.contractInstance.getCityDetails(i);
							that.citiesArray.unshift({
								index: i,
								owner: citiesMessage[0].toString(),
								cityName: citiesMessage[1],
								popu: citiesMessage[2].toString(),
								poli: citiesMessage[3].toString(),
								ecno: citiesMessage[4].toString(),
								muti: citiesMessage[5].toString(),
								coldDown: citiesMessage[6]
								
							});
						}
						that.loadCities = false;
						
            resolve();
          }
        });
				that.fevent.watch(function(err, result) {
					if (!err && result.transactionHash == transactionHash) {
						that.web3.miner.stop();
						that.$message.error(result.args.msg);
						that.sevent.stopWatching();
						that.fevent.stopWatching();
						resolve();
					}
				});
        this.web3.miner.start();
        this.$message("交易正在提交，请稍候……");
      });
    },
		
		expansionPrepare() {
			if (!this.supervisee) {
				this.status = "扩张";
				this.dialogVisible = true;
				this.inputContent = "";
				this.inputContent2 = "";
			}
		},

    expansionConfirm() {
      var that = this;
      this.waitingConfirmButton = true;
      this.contractInstance.expansion(
				parseInt(this.inputContent), 
        this.inputContent2, 
        {
          from: this.web3.eth.accounts[0],
          gas: 9000000
        },
        async function(err, transactionHash) {
          if (err) {
						console.log(err);
            await that.unlockAccount();
            that.waitingConfirmButton = false;
          } else {
            await that.submitTransaction("Success", "Fail", transactionHash);
            that.waitingConfirmButton = false;
            that.dialogVisible = false;
          }
        }
      );
			}, 
			
			createFirstCityPrepare() {
				if (!this.supervisee) {
					this.status = "创建第一座城市";
					this.dialogVisible = true;
					this.inputContent = "";
					this.inputContent2 = "";
				}
			}, 
	
			createFirstCityConfirm() {
				var that = this;
				this.waitingConfirmButton = true;
				this.contractInstance.createRandomCity( 
					this.inputContent, 
					{
						from: this.web3.eth.accounts[0],
						gas: 9000000
					},
					async function(err, transactionHash) {
						if (err) {
							console.log(err);
							await that.unlockAccount();
							that.waitingConfirmButton = false;
						} else {
							await that.submitTransaction("Success", "Fail", transactionHash);
							that.waitingConfirmButton = false;
							that.dialogVisible = false;
						}
					}
				);
			}, 
			
			attackPrepare() {
				if (!this.supervisee) {
					this.status = "进攻";
					this.dialogVisible = true;
					this.inputContent = "";
					this.inputContent2 = "";
				}
			}, 

			attackConfirm() {
				var that = this;
				this.waitingConfirmButton = true;
				this.contractInstance.Invade( 
					this.inputContent, 
					this.inputContent2,
					{
						from: this.web3.eth.accounts[0],
						gas: 9000000
					},
					async function(err, transactionHash) {
						if (err) {
							console.log(err);
							await that.unlockAccount();
							that.waitingConfirmButton = false;
						} else {
							await that.submitTransaction("Success", "Fail", transactionHash);
							that.waitingConfirmButton = false;
							that.dialogVisible = false;
						}
					}
				);
			},

			mergePrepare() {
				if (!this.supervisee) {
					this.status = "合并城市";
					this.dialogVisible = true;
					this.inputContent = "";
					this.inputContent2 = "";
				}
			}, 

			mergeConfirm() {
				var that = this;
				this.waitingConfirmButton = true;
				this.contractInstance.mergeCity( 
					this.inputContent, 
					this.inputContent2, 
					{
						from: this.web3.eth.accounts[0],
						gas: 9000000
					},
					async function(err, transactionHash) {
						if (err) {
							console.log(err);
							await that.unlockAccount();
							that.waitingConfirmButton = false;
						} else {
							await that.submitTransaction("Success", "Fail", transactionHash);
							that.waitingConfirmButton = false;
							that.dialogVisible = false;
						}
					}
				);
			},

			levelUpPrepare() {
				if (!this.supervisee) {
					this.status = "氪金升级";
					this.dialogVisible = true;
					this.inputContent = "";
					this.inputContent2 = "";
				}
			}, 

			levelUpConfirm() {
				var that = this;
				this.waitingConfirmButton = true;
				this.contractInstance.quickLevelUp( 
					this.inputContent, 
					{
						from: this.web3.eth.accounts[0],
						gas: 9000000,
						value: this.inputContent2
					},
					async function(err, transactionHash) {
						if (err) {
							console.log(err);
							await that.unlockAccount();
							that.waitingConfirmButton = false;
						} else {
							await that.submitTransaction("Success", "Fail", transactionHash);
							that.waitingConfirmButton = false;
							that.dialogVisible = false;
						}
					}
				);
			},
// 			transCityPrepare() {
// 				if (!this.supervisee) {
// 					this.status = "转让城市";
// 					this.dialogVisible = true;
// 					this.inputContent = "";
// 					this.inputContent2 = "";
// 				}
// 			}, 
// 
// 			transCityConfirm() {
// 				var that = this;
// 				this.waitingConfirmButton = true;
// 				this.contractInstance.transferOwnership( 
// 					this.inputContent, 
// 					{
// 						from: this.web3.eth.accounts[0],
// 						gas: 9000000
// 					},
// 					async function(err, transactionHash) {
// 						if (err) {
// 							console.log(err);
// 							await that.unlockAccount();
// 							that.waitingConfirmButton = false;
// 						} else {
// 							await that.submitTransaction("Success", "Fail", transactionHash);
// 							that.waitingConfirmButton = false;
// 							that.dialogVisible = false;
// 						}
// 					}
// 				);
// 			},
			changeNamePrepare() {
				if (!this.supervisee) {
					this.status = "城市改名";
					this.dialogVisible = true;
					this.inputContent = "";
					this.inputContent2 = "";
				}
			}, 

			changeNameConfirm() {
				var that = this;
				this.waitingConfirmButton = true;
				this.contractInstance.changeName( 
					this.inputContent,
					this.inputContent2,
					{
						from: this.web3.eth.accounts[0],
						gas: 9000000
					},
					async function(err, transactionHash) {
						if (err) {
							console.log(err);
							await that.unlockAccount();
							that.waitingConfirmButton = false;
						} else {
							await that.submitTransaction("Success", "Fail", transactionHash);
							that.waitingConfirmButton = false;
							that.dialogVisible = false;
						}
					}
				);
			}
  }
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
.el-main {
  padding-top: 0px;
  padding-bottom: 0px;
}

.el-aside {
  padding-left: 20px;
}

.el-header {
  line-height: 60px;
  display: flex;
  justify-content: space-between;
}
</style>