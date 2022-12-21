// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7; 

/*
0.message to sign
1.hash(message)
2.sign(hash(message),private key) | offchain
3.ecrecover(hash(message),signature) == signer
*/
contract VerifySig {
    // _signer：签名的地址    _message：原始数据  _sig签名的数据（签名后的结果）
    function verify (address _signer, string memory _message, bytes memory _sig) external pure returns(bool){
        bytes32 messageHash = getMessageHash(_message);
        bytes32 ethSignedMessageHash = getEthSignedMessageHash(messageHash);
        return recover(ethSignedMessageHash,_sig) == _signer;
    }
    // 对原始数据进行签名
    function getMessageHash(string memory _message) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(_message));
    }

    // 对签名后的数据在进行签名，一次签名有可能被破解，所以在增加一次 （发生的链下）
    function getEthSignedMessageHash(bytes32 _messageHash) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(
            "\x19Ethereum Signed Message:\n32",
            _messageHash
        ));
    }

    // 还原签名的地址
    function recover(bytes32 _ethSignedMessageHash,bytes memory _sig) public pure returns (address) {
        (bytes32 r, bytes32 s, uint8 v) = _split(_sig);
        // ecrecover：solidity自带的签名还原函数
        return ecrecover(_ethSignedMessageHash,v,r,s);
    }
    // 使用汇编对签名后的数据进行分割
    function _split(bytes memory _sig) internal pure returns (bytes32 r, bytes32 s, uint8 v) {
        require(_sig.length == 65,"invalid signature length");
        //隐式返回
        // 前32位是长度
        // 每一次取 32 的长度
        // 最后一位 uint8 占一位 ，但是不是返回bytes32 类型  byte(0，）就能获取一位的uint8
        assembly {
            r := mload(add(_sig,32))
            s := mload(add(_sig,64))
            v := byte(0,mload(add(_sig,96)))
        }
    }
}