-----------------------------------
-- Area: Valkurm Dunes
--  NPC: qm4 (???)
-- Involved In Pirates Chart quest
-- !pos -168 4 -131 103
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if xi.settings.map.FISHING_ENABLE then
        return xi.piratesChart.onTrade(player, npc, trade)
    end
end

entity.onTrigger = function(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
    return xi.piratesChart.onEventUpdate(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    return xi.piratesChart.onEventFinish(player, csid, option, npc)
end

return entity
