pragma solidity ^0.4.4;

import 'erc20/erc20.sol';
import 'dapple/env.sol';
import 'dapple/script.sol';
import './interfaces.sol';

contract DeployMockTokenAndWrapper is Script {
    function DeployMockTokenAndWrapper() {
        var token = new ERC20Base(100 * 10**18);
        var wrapper = new TokenWrapper(ReducedToken(address(token)));
        exportObject("mock_token", token);
        exportObject("mock_token_wrapper", wrapper);
    }
}
