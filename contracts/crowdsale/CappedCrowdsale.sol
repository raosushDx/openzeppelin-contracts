pragma solidity ^0.4.11;

import '../SafeMath.sol';
import './Crowdsale.sol';

/**
 * @title CappedCrowdsale
 * @dev Extension of Crowsdale with a max amount of funds raised
 */
contract CappedCrowdsale is Crowdsale {
  using SafeMath for uint256;

  uint256 public cap;

  function CappedCrowdsale(
    uint256 _cap
  ) {
    cap = _cap;
  }

  // overriding Crowdsale#canBuy to add extra cap logic
  // @return true if investors can buy at the moment
  function canBuy() internal constant returns (bool) {
    bool withinCap = weiRaised.add(msg.value) <= cap;
    return super.canBuy() && withinCap;
  }

  // overriding Crowdsale#hasEnded to add cap logic
  // @return true if crowdsale event has ended
  function hasEnded() public constant returns (bool) {
    bool capReached = weiRaised >= cap;
    return super.hasEnded() || capReached;
  }

}
