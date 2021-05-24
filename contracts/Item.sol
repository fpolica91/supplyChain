// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./ItemManager.sol";

contract Item {
    uint256 public priceInWei;
    uint256 public paidInWei;
    uint256 public index;

    ItemManager parentContract;

    constructor(
        ItemManager _parentContract,
        uint256 _priceInWei,
        uint256 _index
    ) public {
        priceInWei = _priceInWei;
        index = _index;
        parentContract = _parentContract;
    }

    receive() external payable {
        require(msg.value == priceInWei, "We do not support partial payments");
        require(paidInWei == 0, "Item is already paid");
        paidInWei += msg.value;
        (bool success, ) =
            address(parentContract).call{value: msg.value}(
                abi.encodeWithSignature("triggerPayment(uint256)", index)
            );
        require(success, "Delivery did not work");
    }

    fallback() external {}
}
// WARN:@google-cloud/error-reporting: The stackdriver error reporting client is configured to report errors if and only if the NODE_ENV environment variable is set to "production". Errors will not be reported.  To have errors always reported, regardless of the value of NODE_ENV, set the reportMode configuration option to "always".
