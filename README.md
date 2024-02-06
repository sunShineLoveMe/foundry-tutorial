## Foundry

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

-   **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools). -- Foundry项目执行初始化项目、管理依赖、测试、构建、部署智能合约的命令工具。
-   **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data. -- Foundry项目中与RPC节点交互的命令工具。可以进行智能合约的调用、发送交易数据或者检索任何类型的链上数据。
-   **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network. -- Foundry项目中启动本地测试网\节点的命令行工具。可以使用它配合测试前端应用与部署在该测试网的合约通过RPC进行交互。
-   **Chisel**: Fast, utilitarian, and verbose solidity REPL。

## 相关文档

https://book.getfoundry.sh/

## 用法
### 基本项目结构
```
.
├── foundry.toml        # Foundry 的 package 配置文件
├── lib                 # Foundry 的依赖库
│   └── forge-std       # 工具 forge 的基础依赖
├── script              # Foundry 的脚本
│   └── Counter.s.sol   # 示例合约 Counter 的脚本
├── src                 # 智能合约的业务逻辑、源代码将会放在这里
│   └── Counter.sol     # 示例合约
└── test                # 测试用例目录
    └── Counter.t.sol   # 示例合约的测试用例
```
以上的项目结构中有一点需要解释下<br/>
1. 依赖项作为 git submodule 在 ./lib 目录中
   git submodule 是git的特性之一，它允许将其他git仓库作为主要仓库的子目录包含进来。
2. git submodule与依赖库的引用的区别是 
  - 版本控制
    - Git submodule 是指向特定提交（commit）的引用，因此在主仓库中记录了子模块的确切版本
    - 依赖库的引用通常是指向一个范围（例如一个版本号或语义化版本号），而不是特定的提交
  - 管理方式
    - Git submodule 需要单独初始化和更新子模块，因为它们是独立的 Git 仓库
    - 依赖库的引用通常由构建系统或包管理器管理，它们可能会自动下载并管理依赖项
  - 目的
    - Git submodule 通常用于将另一个仓库作为项目的一部分引入，并允许对其进行修改和贡献
    - 依赖库的引用通常用于在构建或运行时获取所需的库或包，而不需要对其进行修改
### Cheatcode reference
Foundry有一套作弊码，它可以对区块链的状态进行修改，以方便在测试的时候使用。这些代码可以直接执行合约。
1. prank
    ``` 
    function prank(address) external;
    设置地址作为下一次调用的msg.sender;
    ```
2. assume
   ```
   function assume(bool) external;
   ```
3. warp
   ```
   vm.warp(uint256) external;
   设置 block.timestamp
   ```
4. roll
   ```
   vm.roll(uint256) external;
   设置 block.height
   ```
5. startPrank
   ```
   vm.startPrank(uint256) external;
   设置地址作为所有后续调用的msg.sender
   ```
6. stopPrank
   ```
   vm.stopPrank(uint256) external;
   重置后续调用msg.sender为address(this)
   ```
7. deal
   ```
   vm.deal(address, uint256) external
   设置一个地址的余额，参数：（who，newBalance）
   ```
8. expectRevert
   ```
   vm.expectRevert(bytes calldata) external; 期待下次调用时出现错误
   ```
9. record
   ```
   vm.record() external; 记录所有存储的读和写
   ```            
10. expectEmit
   ```
   vm.expectEmit(true, false, false, false); emit Transfer(address(this)); transfer(); 检查事件主题1在两个事件中是否相等
   ``` 
11. load
   ```
   vm.load(address,bytes32)外部返回(bytes32); 从一个地址加载一个存储槽
   ``` 
12. store
   ```
   vm.store(address,bytes32,bytes32) external; 将一个值存储到一个地址的存储槽中，参数（who, slot, value）
   ```     

### 相关问题以及解决方案
1. 安装依赖包
   ```
   forge install OpenZeppelin/openzeppelin-contracts --no-commit
   ```
   注意末尾的--no-commit标志，这个意思是你的项目文件已经与git存储库关联，所以我们必须指定不提交任何内容.<br/>
2. 编写自动化测试   
   在test目录中约定具有test开头的函数的合约都被认为是一个测试。  
   ```
    function testSetNumber(uint256 x) public {
        counter.setNumber(x);
        assertEq(counter.counter(), x);
    }
   ```
   上面的testSetNumber函数，带有一个参数x,它使用了基于属性的模糊测试，forge模糊器默认会随机指定256个值运行测试.
3. 在自动化测试中，测试结果如下
   ![测试结果](/images/WX20240206-142045@2x.png)
   在模糊测试中的(runs: 256, μ: 28064, ~: 28453)，含义是:
   - run 是指模糊器fuzzer 测试的场景数量。默认情况下，模糊器fuzzer将生成256个场景，但是，其可以使用FOUNDRY_FUZZ_RUNS进行环境变量配置.
   - “μ”（希腊字母） mu 是指所有模糊器运行中使用的平均值
   - “~”（波浪号）是指所有模糊器运行使用的中值Gas
4. forge test的默认行为是只显示通过和失败测试的摘要。可以使用-vv标志通过增加日志详细程度.
   ![日志结果](/images/WX20240206-144900@2x.png)
5. 标准库
   标准库封装了很多好的方法直接使用，分为四个部分
   - Vm.sol:提供作弊码（Cheatcodes）
   - console.sol和console2.sol Hardhat 风格的日志记录功能，console2.sol包含console.sol 的补丁
   - Test.sol：DSTest 的超集，包含标准库、作弊码实例和Foundry控制台.   