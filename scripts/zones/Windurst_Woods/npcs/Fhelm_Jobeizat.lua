-----------------------------------
-- Area: Windurst Woods
--  NPC: Fhelm Jobeizat
-- Records of Eminence NPC
-- !pos 89.049 -4.108 -46.195 241
-----------------------------------
local ID = require("scripts/zones/Windurst_Woods/IDs")
require("scripts/globals/sparkshop")
require("scripts/globals/msg")
require("scripts/globals/roe")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.sparkshop.onTrade(player, npc, trade, 860)
end

entity.onTrigger = function(player, npc)
    if player:getEminenceProgress(1) then
        player:startEvent(848, 0, player:getGil())
    elseif not player:hasKeyItem(xi.ki.MEMORANDOLL) then
        player:startEvent(849)
    else
        player:triggerRoeEvent(xi.roe.triggers.talkToRoeNpc)
        player:messageSpecial(ID.text.TRRRADE_IN_SPARKS)
        xi.sparkshop.onTrigger(player, npc, 850)
    end
end

entity.onEventUpdate = function(player, csid, option)
    xi.sparkshop.onEventUpdate(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 848 and option == 1 then
        xi.roe.onRecordTrigger(player, 1)
        player:messageBasic(xi.msg.basic.ROE_BONUS_ITEM_PLURAL, 4376, 6)
    end
end

return entity
