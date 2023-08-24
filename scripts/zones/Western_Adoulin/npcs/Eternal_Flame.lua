-----------------------------------
-- Area: Western Adoulin
--  NPC: Eternal Flame
-- Records of Eminence NPC
-----------------------------------
local ID = require("scripts/zones/Western_Adoulin/IDs")
require("scripts/globals/sparkshop")
require("scripts/globals/msg")
require("scripts/globals/roe")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.sparkshop.onTrade(player, npc, trade, 5086)
end

entity.onTrigger = function(player, npc)
    if player:getEminenceProgress(1) then
        player:startEvent(5079)
    elseif not player:hasKeyItem(xi.ki.MEMORANDOLL) then
        player:startEvent(5080)
    else
        player:triggerRoeEvent(xi.roe.triggers.talkToRoeNpc)
        player:messageSpecial(ID.text.SPARK_EXCHANGE)
        xi.sparkshop.onTrigger(player, npc, 5081)
    end
end

entity.onEventUpdate = function(player, csid, option)
    xi.sparkshop.onEventUpdate(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 5079 and option == 1 then
        xi.roe.onRecordTrigger(player, 1)
        player:messageBasic(xi.msg.basic.ROE_BONUS_ITEM_PLURAL, 4376, 6)
    end
end

return entity
