-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Rolandienne
-- Records of Eminence NPC
-----------------------------------
local ID = require("scripts/zones/Southern_San_dOria/IDs")
require("scripts/globals/sparkshop")
require("scripts/globals/keyitems")
require("scripts/globals/msg")
require("scripts/globals/roe")
-----------------------------------
local entity = {}

entity.onTrade = function(player,npc,trade)
    tpz.sparkshop.onTrade(player,npc,trade)
end

entity.onTrigger = function(player,npc)
    if player:getEminenceProgress(1) then
        player:startEvent(993)
    elseif player:hasKeyItem(tpz.ki.MEMORANDOLL) == false then
        player:startEvent(994)
    else
        player:messageSpecial(ID.text.YOU_WISH_TO_EXCHANGE_SPARKS)
        tpz.sparkshop.onTrigger(player,npc,995)
    end
end

entity.onEventUpdate = function(player,csid,option)
    tpz.sparkshop.onEventUpdate(player,csid,option)
end

entity.onEventFinish = function(player,csid,option)
    if csid == 993 and option == 1 then
        tpz.roe.onRecordTrigger(player, 1)
        player:messageBasic(tpz.msg.basic.ROE_BONUS_ITEM_PLURAL,4376,6)
    end
end

return entity
