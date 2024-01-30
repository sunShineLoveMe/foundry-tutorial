## Foundry

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

-   **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools). -- Foundry项目执行初始化项目、管理依赖、测试、构建、部署智能合约的命令工具。
-   **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data. -- Foundry项目中与RPC节点交互的命令工具。可以进行智能合约的调用、发送交易数据或者检索任何类型的链上数据；
-   **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network. -- Foundry项目中启动本地测试网\节点的命令行工具。可以使用它配合测试前端应用与部署在该测试网的合约通过RPC进行交互。
-   **Chisel**: Fast, utilitarian, and verbose solidity REPL.

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
1. prank
    ``` 
    function prank(address) external;
    Description: Sets msg.sender to the specified address for the next call
    ```
2. assume
   ```
   function assume(bool) external;
    Description: 
   ```

### 相关问题以及解决方案
1. 安装依赖包
   ```
   forge install OpenZeppelin/openzeppelin-contracts --no-commit
   ```
   注意末尾的--no-commit标志，这个意思是你的项目文件已经与git存储库关联，所以我们必须指定不提交任何内容。