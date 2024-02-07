// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "./interface.sol";

// Usage: From root folder, run -
// forge test --contracts ./test/Attack.sol -vv

contract Attack is Test {
    IERC20 private constant WBTC = IERC20(0x2f2a2543B76A4166549F7aaB2e75Bef0aefC5B0f);
    IERC20 private constant EURO = IERC20(0x643b34980E635719C15a2D4ce69571a258F940E9);
    IWETH private constant WETH = IWETH(payable(0x82aF49447D8a07e3bd95BD0d56f35241523fBab1));
    IUSDC private constant USDC = IUSDC(0xFF970A61A04b1cA14834A43f5dE4533eBDDB5CC8);
    Uni_Pair_V3 private constant WBTC_WETH = Uni_Pair_V3(0x2f5e87C9312fa29aed5c179E456625D79015299c);
    Uni_Router_V3 private constant Router = Uni_Router_V3(0xE592427A0AEce92De3Edee1F18E0157C05861564);

    function setUp() public {
        vm.createSelectFork("arbitrum", 147_817_765);
        vm.label(address(WBTC), "WBTC");
        vm.label(address(EURO), "EURO");
        vm.label(address(USDC), "USDC");
    }

    function testExploit() public {
        deal(address(WBTC), address(this), 100e8 + 5219);

        emit log_named_decimal_uint("Attacker WBTC balance before exploit", WBTC.balanceOf(address(this)), 8);

        //*********************************************************
        //**********************  ATTACK  *************************

        //*********************************************************

        emit log_named_decimal_uint("Attacker WBTC balance after  exploit", WBTC.balanceOf(address(this)), 8);
    }

    function uniswapV3FlashCallback(uint256 fee0, uint256 fee1, bytes calldata data) external {
    }

    function onERC721Received(
        address operator,
        address from,
        uint256 tokenId,
        bytes calldata data
    ) external returns (bytes4) {
        return this.onERC721Received.selector;
    }
}