// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "openzeppelin-contracts-upgradeable/contracts/token/ERC20/ERC20Upgradeable.sol";
import "openzeppelin-contracts-upgradeable/contracts/access/OwnableUpgradeable.sol";
import "openzeppelin-contracts-upgradeable/contracts/token/ERC20/extensions/ERC20PermitUpgradeable.sol";
import "openzeppelin-contracts-upgradeable/contracts/proxy/utils/Initializable.sol";
import "openzeppelin-contracts-upgradeable/contracts/proxy/utils/UUPSUpgradeable.sol";

/// @custom:oz-upgrades-from MyToken
contract MyTokenV2 is 
    Initializable, 
    ERC20Upgradeable, 
    OwnableUpgradeable, 
    ERC20PermitUpgradeable, 
    UUPSUpgradeable 
    {
        /// @custom:oz-upgrades-unsafe-allow constructor
        constructor() {
            //确保只能初始化一次
            _disableInitializers();
        }

        // 所有权分配给initialOwner, 并激活了增强的授权机制和可升级功能。
        function initialize(address initialOwner) initializer public {
            __ERC20_init("MyTokenV2", "MTKV2");
            __Ownable_init(initialOwner);
            __ERC20Permit_init("MyTokenV2");
            __UUPSUpgradeable_init();

            _mint(msg.sender, 1000000 * 10 ** decimals());
        }

        // 仅限所有者的mint函数
        function mint(address to, uint256 amount) public onlyOwner {
            _mint(to, amount);
        }

        // 通过内部的_authorizeUpgrade方法，确保了安全的合约升级，只允许所有者授权新的合约版本
        function _authorizeUpgrade(address newImplementation) internal override onlyOwner { 

        }

    }
