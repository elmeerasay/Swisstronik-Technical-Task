// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract AutoMintERC721 is ERC721, Ownable {
    uint256 private _currentTokenId = 0;

    constructor() ERC721("AutoMintToken", "AMT") {}

    receive() external payable {
        require(msg.value == 0, "Send 0 ETH to mint a token");
        _mintToken(msg.sender);
    }

    function _mintToken(address recipient) internal {
        _currentTokenId++;
        _safeMint(recipient, _currentTokenId);
    }

    function mintToken(address recipient) external onlyOwner {
        _mintToken(recipient);
    }
}
