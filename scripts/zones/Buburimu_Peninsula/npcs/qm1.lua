-----------------------------------
-- Area: Buburimu Peninsula
--  NPC: qm1 (???)
-- Involved in Brigand's Chart quest
-- !pos -87.2 20.4 -336.4 118
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if xi.settings.map.FISHING_ENABLE then
        return xi.brigandsChart.onTrade(player, npc, trade)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
    return xi.brigandsChart.onEventUpdate(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    return xi.brigandsChart.onEventFinish(player, csid, option, npc)
end

return entity
