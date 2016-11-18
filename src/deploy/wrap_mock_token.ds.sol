pragma solidity ^0.4.4;

import 'erc20/erc20.sol';
import 'dapple/env.sol';
import './interfaces.sol';

contract DeployMockTokenAndWrapper is DappleEnv {
    function DeployMockTokenAndWrapper {
        var token = new ERC20Base(100 * 10**18);
        var wrapper = new TokenWrapper(ReducedToken(address(token)));
        export("mock_token", token);
        export("mock_token_wrapper", mock_wrapper);
    }
}
