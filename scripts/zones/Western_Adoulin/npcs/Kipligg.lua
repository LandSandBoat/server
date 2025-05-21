-----------------------------------
-- Area: Western Adoulin
--  NPC: Kipligg
-- !pos -32 0 22 256
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:getCurrentMission(xi.mission.log_id.SOA) < xi.mission.id.soa.LIFE_ON_THE_FRONTIER then
        -- Dialogue prior to joining colonization effort
        player:startEvent(571)
    else
        -- Dialogue after joining colonization effort
        player:startEvent(589)
    end
end

return entity
