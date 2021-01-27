-----------------------------------
-- Area: Bastok Markets
--  NPC: Isakoth
-- Records of Eminence NPC
-----------------------------------
local ID = require("scripts/zones/Bastok_Markets/IDs")
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
        player:startEvent(24)
    elseif player:hasKeyItem(tpz.ki.MEMORANDOLL) == false then
        player:startEvent(25)
    else
        player:messageSpecial(ID.text.TURNING_IN_SPARKS)
        tpz.sparkshop.onTrigger(player,npc,26)
    end
end

entity.onEventUpdate = function(player,csid,option)
    tpz.sparkshop.onEventUpdate(player,csid,option)
end

entity.onEventFinish = function(player,csid,option)
    if csid == 24 and option == 1 then
        tpz.roe.onRecordTrigger(player, 1)
        player:messageBasic(tpz.msg.basic.ROE_BONUS_ITEM_PLURAL,4376,6)
    end
end

return entity
