pragma solidity ^0.4.4;

import "dapple/env.sol";
import "dapple/test.sol";

contract GolemWrapperIntegrationTest is Test,DappleEnv {

    address[] addrs;

    function testBalances() {

        // addresses are recent transactions from http://etherscan.io - GNT token
        addrs[addrs.length++] = 0x6AfBB3Fb10fD9E33b091E3053e956c0A286062BE;
        addrs[addrs.length++] = 0x007c6C254b6B7046d505cF9E13E6321EF78e64D9;
        addrs[addrs.length++] = 0x0020DbA1d308339182239056A00FCC146D2e26e0;

        for(uint i = 0; i<addrs.length; i++) {
            //@log `address addrs[i]`: `uint token.balanceOf(addrs[i])`:
        }
    }
}
