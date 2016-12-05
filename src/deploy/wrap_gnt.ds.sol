pragma solidity ^0.4.4;

import 'dapple/script.sol';
import '../interfaces.sol';
import '../wrapper.sol';

contract DeployGNTWrapper is Script {
    function DeployGNTWrapper() {
        var wrapper = new TokenWrapper(ReducedToken(address(env.gnt)));
        exportObject("GNT_wrapper", wrapper);
    }
}
