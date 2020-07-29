-----------------------------------
-- Area: temenos
-- NPC:  Matter diffusion module
-- !pos
-----------------------------------

require("scripts/globals/limbus")
require("scripts/globals/keyitems")
local ID = require("scripts/zones/Temenos/IDs")

function onTrade(player, npc, trade)
local count = trade:getItemCount()
local InstanceTrade=0
if (player:hasKeyItem(tpz.ki.COSMOCLEANSE) and player:hasKeyItem(tpz.ki.WHITE_CARD) ) then


     if (count==1 and trade:hasItemQty(2127, 1)) then -- Central Temenos - Basement 1
       InstanceTrade=128
     elseif (count==1 and trade:hasItemQty(1906, 1)) then -- Central Temenos - 1st Floor
       InstanceTrade=64
     elseif (count==1 and trade:hasItemQty(1905, 1)) then -- Central Temenos - 2st Floor
       InstanceTrade=32
     elseif (count==1 and trade:hasItemQty(1904, 1)) then -- Central Temenos - 3st Floor
       InstanceTrade=16
     elseif (count==3 and trade:hasItemQty(1986, 1) and trade:hasItemQty(1908, 1) and trade:hasItemQty(1907, 1)) then --proto-ultima
       InstanceTrade=8
     end
  else
       player:messageSpecial(ID.text.CONDITION_FOR_LIMBUS_T)
     print("error player  don't have cosmo clean")
  end

   if (InstanceTrade~=0) then
   player:setCharVar("Limbus_Trade_Item-T", InstanceTrade)
   player:tradeComplete()
   player:messageSpecial(ID.text.CHIP_TRADE_T)
   player:startEvent(32000, 0, 0, 0, InstanceTrade, 0, 0, 0, 0)
   player:setCharVar("limbusbitmap", InstanceTrade)
   end



end

function onTrigger(player, npc)
 local instancelist ={}
 local limbusbitmap = 0
 local AllowLimbusToPlayer = true
 local currentlimbus= TryTobackOnCurrentLimbus(player)


         instancelist = TEMENOS_LIST

  printf("currentlimbus: %u", currentlimbus)


   if (player:hasKeyItem(tpz.ki.COSMOCLEANSE)) then
       if (player:hasStatusEffect(tpz.effect.BATTLEFIELD) == false) then
         local LimbusTradeItem = player:getCharVar("Limbus_Trade_Item-T")
           for nt = 1, #instancelist, 2 do
                --    printf("list d'instance: %u", instancelist[nt])
               if (instancelist[nt+1][1]==true and player:hasKeyItem(tpz.ki.WHITE_CARD)) then
               --    print("player_have_white_card")
                   limbusbitmap = limbusbitmap + instancelist[nt+1][4]
               --   printf("bitmapadd: %u", instancelist[nt+1][4])
               end
               if (instancelist[nt+1][2]==true and player:hasKeyItem(tpz.ki.RED_CARD)) then
                --  print("player_have_red_card")
                    limbusbitmap = limbusbitmap + instancelist[nt+1][4]
                --   printf("bitmapadd: %u", instancelist[nt+1][4])
               end
               if (instancelist[nt+1][3]==true and player:hasKeyItem(tpz.ki.BLACK_CARD)) then
                 -- print("player_have_black_card")
                    limbusbitmap = limbusbitmap + instancelist[nt+1][4]
                 --  printf("bitmapadd: %u", instancelist[nt+1][4])
               end
           end
        limbusbitmap= limbusbitmap + LimbusTradeItem
      ----- /////////////////////////////////////////////on doit ajouter le mipmap pour l'item trade ici
       else
             local    status = player:getStatusEffect(tpz.effect.BATTLEFIELD)
            local    playerbcnmid = status:getPower()
           -- check if the player has the key item for the current battlefield
           for nt = 1, #instancelist, 2 do
               --     printf("list d'instance: %u", instancelist[nt])
                    if (instancelist[nt] == playerbcnmid) then
                        if (instancelist[nt+1][1]== true and player:hasKeyItem(tpz.ki.WHITE_CARD) == false) then
                           AllowLimbusToPlayer = false
                        end
                        if (instancelist[nt+1][2]== true  and player:hasKeyItem(tpz.ki.RED_CARD) == false ) then
                           AllowLimbusToPlayer = false
                        end
                        if (instancelist[nt+1][3]== true and player:hasKeyItem(tpz.ki.BLACK_CARD) == false ) then
                           AllowLimbusToPlayer = false
                        end
                        if (AllowLimbusToPlayer == true) then --player have the correct key item for the current battflield
                           limbusbitmap = instancelist[nt+1][4]
                        end

                    end
           end



       end




       if (limbusbitmap~= 0 ) then
           player:startEvent(32000, 0, 0, 0, limbusbitmap, 0, 0, 0, 0)
        player:setCharVar("limbusbitmap", limbusbitmap)
       else
       player:messageSpecial(ID.text.CONDITION_FOR_LIMBUS_T)
        print("player need a card for basic limbus")
        end

  elseif (currentlimbus~=0) then
           for nt = 1, #instancelist, 2 do
               --     printf("list d'instance: %u", instancelist[nt])
                    if (instancelist[nt] == currentlimbus) then
                           limbusbitmap = instancelist[nt+1][4]
                    end
           end
        player:startEvent(32000, 0, 0, 0, limbusbitmap, 0, 0, 0, 0)
        player:setCharVar("limbusbitmap", limbusbitmap)

  else
       player:messageSpecial(ID.text.CONDITION_FOR_LIMBUS_T)
    print("error player  don't have cosmo clean")
  end

end

function onEventUpdate(player, csid, option)


     if (csid == 32000) then
       if (player:hasStatusEffect(tpz.effect.BATTLEFIELD) == false) then
           ResetPlayerLimbusVariable(player)
           player:setCharVar("characterLimbusKey", 0)
       else
               local status = player:getStatusEffect(tpz.effect.BATTLEFIELD)
            player:setCharVar("LimbusID", status:getPower())
             player:setCharVar("characterLimbusKey", GetLimbusKeyFromInstance(status:getPower()))
       end
     player:updateEvent(2, player:getCharVar("limbusbitmap"), 0, 1, 1, 0)
     player:setCharVar("limbusbitmap", 0)


     end

end

function onEventFinish(player, csid, option)
   if (csid == 32000) then

   end
end
