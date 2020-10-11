-----------------------------------
-- Area: Appolyon
-- NPC:  Radiant_Aureole
-- !pos
-----------------------------------
require("scripts/globals/limbus")
require("scripts/globals/keyitems")

local ID = require("scripts/zones/Apollyon/IDs")
function onTrade(player, npc, trade)
local count = trade:getItemCount()
if (player:hasKeyItem(tpz.ki.COSMOCLEANSE)) then
  if (count==1 and trade:hasItemQty(2127, 1)) then-- metal chip
     player:setCharVar("Limbus_Trade_Item", 32)
     player:tradeComplete()
     player:messageSpecial(ID.text.CHIP_TRADE)
         player:startEvent(32000, 0, 0, 0, 32, 0, 0, 0, 0)
        player:setCharVar("limbusbitmap", 32)
  elseif (count==4 and trade:hasItemQty(1988, 1) and trade:hasItemQty(1987, 1) and trade:hasItemQty(1910, 1) and trade:hasItemQty(1909, 1)) then
    player:setCharVar("Limbus_Trade_Item", 16)
    player:tradeComplete()
    player:messageSpecial(ID.text.CHIP_TRADE)
    player:startEvent(32000, 0, 0, 0, 16, 0, 0, 0, 0)
    player:setCharVar("limbusbitmap", 16)
  end
 else
       player:messageSpecial(ID.text.CONDITION_FOR_LIMBUS)
     print("error player  don't have cosmo clean")
 end

end

function onTrigger(player, npc)
 local instancelist ={}
 local limbusbitmap = 0
 local AllowLimbusToPlayer = true
 local currentlimbus= TryTobackOnCurrentLimbus(player)

  if ( npc:getID() == 16933242) then
         instancelist = APOLLYON_SE_NE_BCNM_LIST
  else
         instancelist = APOLLYON_NW_SW_BCNM_LIST
 end
printf("currentlimbus: %u", currentlimbus)


   if (player:hasKeyItem(tpz.ki.COSMOCLEANSE)) then
       if (player:hasStatusEffect(tpz.effect.BATTLEFIELD) == false) then
         local LimbusTradeItem = player:getCharVar("Limbus_Trade_Item")
           for nt = 1, #instancelist, 2 do
                 --   printf("list d'instance: %u", instancelist[nt])
               if (instancelist[nt+1][1]==true and player:hasKeyItem(tpz.ki.WHITE_CARD)) then
                --   print("player_have_white_card")
                   limbusbitmap = limbusbitmap + instancelist[nt+1][4]
                --   printf("bitmapadd: %u", instancelist[nt+1][4])
               end
               if (instancelist[nt+1][2]==true and player:hasKeyItem(tpz.ki.RED_CARD)) then
                --   print("player_have_red_card")
                    limbusbitmap = limbusbitmap + instancelist[nt+1][4]
               --     printf("bitmapadd: %u", instancelist[nt+1][4])
               end
               if (instancelist[nt+1][3]==true and player:hasKeyItem(tpz.ki.BLACK_CARD)) then
                --   print("player_have_black_card")
                    limbusbitmap = limbusbitmap + instancelist[nt+1][4]
                 --   printf("bitmapadd: %u", instancelist[nt+1][4])
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
       player:messageSpecial(ID.text.CONDITION_FOR_LIMBUS)
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
       player:messageSpecial(ID.text.CONDITION_FOR_LIMBUS)
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
