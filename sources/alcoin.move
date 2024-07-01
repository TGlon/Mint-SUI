module alcoin::ALCOIN {   
  use std::option;
  use sui::tx_context::{Self, TxContext};
  use sui::transfer;
  use sui::coin::{Self, Coin, TreasuryCap};
  use sui::url::{Self, Url};
  
  
  const AMOUNT: u64 = 600000000000000000;
  public struct ALCOIN has drop {}

  
  fun init(witness: ALCOIN, ctx: &mut TxContext) {
    let icon_url = option::some(url::new_unsafe_from_bytes(b"https://i.pinimg.com/736x/24/cb/23/24cb23de2f32c5195d1df9ad7232c898.jpg"));
      let (mut treasury, metadata) = coin::create_currency<ALCOIN>(
            witness, 
            9,
            b"ALTOKEN",
            b"ALong",
            b"Along Token",
            icon_url,
            ctx
        );

      let sender = tx_context::sender(ctx);  

      coin::mint_and_transfer(&mut treasury, AMOUNT, sender, ctx);

      transfer::public_transfer(treasury, sender);

      transfer::public_freeze_object(metadata);
  }

  public entry fun mint(
        cap: &mut TreasuryCap<ALCOIN>, value: u64, sender: address, ctx: &mut TxContext,
    ) {
     coin::mint_and_transfer(cap, value, sender, ctx);
  }

  public entry fun transfer(c: Coin<ALCOIN>, recipient: address) {
    transfer::public_transfer(c, recipient);
  }
}

