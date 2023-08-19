-----------------------------------
-- Area: Qu'Bia Arena
--  NPC: Burning Circle
-- !pos -221 -24 19 206
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.bcnm.onTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- if player:hasKeyItem(xi.ki.MARK_OF_SEED) and player:getCurrentMission(xi.mission.log_id.ACP) == xi.mission.id.acp.THOSE_WHO_LURK_IN_SHADOWS_II then
    --     player:startEvent(5)
    -- else xi.bcnm.onTrigger(player, npc)
    -- Temp disabled pending fixes for the BCNM mobs.

    xi.bcnm.onTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option, extras)
    xi.bcnm.onEventUpdate(player, csid, option, extras)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 5 then
        player:completeMission(xi.mission.log_id.ACP, xi.mission.id.acp.THOSE_WHO_LURK_IN_SHADOWS_II)
        player:addMission(xi.mission.log_id.ACP, xi.mission.id.acp.THOSE_WHO_LURK_IN_SHADOWS_III)
    else
        xi.bcnm.onEventFinish(player, csid, option, npc)
    end
end

return entity
