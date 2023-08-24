-----------------------------------
-- Area: Bastok Markets
--  NPC: Isakoth
-- Records of Eminence NPC
-----------------------------------
local ID = require("scripts/zones/Bastok_Markets/IDs")
require("scripts/globals/sparkshop")
require("scripts/globals/msg")
require("scripts/globals/roe")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.sparkshop.onTrade(player, npc, trade, 27)
end

entity.onTrigger = function(player, npc)
    if player:getEminenceProgress(1) then
        player:startEvent(24)
    elseif not player:hasKeyItem(xi.ki.MEMORANDOLL) then
        player:startEvent(25)
    else
        player:triggerRoeEvent(xi.roe.triggers.talkToRoeNpc)
        player:messageSpecial(ID.text.TURNING_IN_SPARKS)
        xi.sparkshop.onTrigger(player, npc, 26)
    end
end

entity.onEventUpdate = function(player, csid, option)
    xi.sparkshop.onEventUpdate(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 24 and option == 1 then
        xi.roe.onRecordTrigger(player, 1)
        player:messageBasic(xi.msg.basic.ROE_BONUS_ITEM_PLURAL, 4376, 6)
    end
end

return entity
