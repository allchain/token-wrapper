pragma solidity ^0.4.4;

import 'dapple/env.sol';
import './interfaces.sol';

contract DeployGNTWrapper is DappleEnv {
    function DeployGNTWrapper() {
        var wrapper = new TokenWrapper(ReducedToken(address(env.gnt)));
        export("GNT_wrapper", wrapper);
    }
}
