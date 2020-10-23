-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Rolandienne
-- Records of Eminence NPC
-----------------------------------
require("scripts/globals/msg")
require("scripts/globals/keyitems")
require("scripts/globals/sparkshop")
local ID = require("scripts/zones/Southern_San_dOria/IDs")

function onTrade(player,npc,trade)
end

function onTrigger(player,npc)
    if player:getEminenceProgress(1) then
        player:startEvent(993)
    elseif player:hasKeyItem(tpz.ki.MEMORANDOLL) == false then
        player:startEvent(994)
    else
        player:messageSpecial(ID.text.YOU_WISH_TO_EXCHANGE_SPARKS)
        tpz.sparkshop.onTrigger(player,npc,995)
    end
end

function onEventUpdate(player,csid,option)
    tpz.sparkshop.onEventUpdate(player,csid,option)
end

function onEventFinish(player,csid,option)
    if csid == 993 and option == 1 then
        tpz.roe.onRecordTrigger(player, 1)
        player:messageBasic(tpz.msg.basic.ROE_BONUS_ITEM_PLURAL,4376,6)
    end
end
