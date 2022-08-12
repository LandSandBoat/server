-----------------------------------
-- Area: Yuhtunga Jungle
--  NPC: Logging Point
-----------------------------------
require("scripts/globals/helm")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.WISH_UPON_A_STAR) == QUEST_ACCEPTED and
    not player:hasItem(xi.items.FALLEN_STAR) and npcUtil.tradeHasExactly(trade, xi.items.HATCHET) then
        player:confirmTrade()
        player:startEvent(205, xi.items.FALLEN_STAR)
        player:addItem(xi.items.FALLEN_STAR)
    else
        xi.helm.onTrade(player, npc, trade, xi.helm.type.LOGGING, 205)
    end
end

entity.onTrigger = function(player, npc)
    xi.helm.onTrigger(player, xi.helm.type.LOGGING)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
