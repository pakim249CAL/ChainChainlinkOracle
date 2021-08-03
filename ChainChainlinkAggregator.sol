// SPDX-License-Identifier: agpl-3.0
pragma solidity ^0.8.6;

/*
* The interface AAVE's Oracle uses
*/
interface IChainlinkAggregator {
  function latestAnswer() external view returns (int);
  function decimals() external view returns (uint8);
}

/*
* This contract uses two chainlink price feeds to make a new price feed
* and has the interface needed for AAVE to interact with it.
* For price feeds A -> B and C -> B, outputs A -> C
*/
contract ChainChainlinkAggregator is IChainlinkAggregator {

    address internal priceFeedAddress1;
    address internal priceFeedAddress2;
    IChainlinkAggregator internal priceFeed1;
    IChainlinkAggregator internal priceFeed2;

    /**
     * 
     */
    constructor(address p1, address p2) {
        priceFeedAddress1 = p1;
        priceFeedAddress2 = p2;
        priceFeed1 = IChainlinkAggregator(p1);
        priceFeed2 = IChainlinkAggregator(p2);
    }
    
    function getPrice1() external view returns (int) {
        return priceFeed1.latestAnswer();
    }    
    function getPrice2() external view returns (int) {
        return priceFeed2.latestAnswer();
    }
    function getPriceSource1() public view returns (address) {
        return priceFeedAddress1;
    }
    function getPriceSource2() public view returns (address) {
        return priceFeedAddress2;
    }
    
    function getRoundNumber() public view returns (int) {
        return priceFeed1.
    }
    /**
     * Converts asset A price to asset C price using two feeds and returns 18 decimal point precision
     */
    function latestAnswer() external view virtual override returns (int) {
        int price1 = getPrice1;
        int price2 = getPrice2;
        uint8 price1d = priceFeed1.decimals();
        uint8 price2d = priceFeed2.decimals();
        if (price2 > 0) {
            return (price1 * int(10 ** (price2d - price1d + uint8(18))) / price2);
        }
        else {
            return 0;
        }
    }
    function decimals() external view virtual override returns (uint8) {
        return uint8(18);
    }
}
