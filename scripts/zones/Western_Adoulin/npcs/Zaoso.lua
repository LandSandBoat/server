-----------------------------------
-- Area: Western Adoulin
--  NPC: Zaoso
-- !pos -94 3 -11 256
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:getCurrentMission(xi.mission.log_id.SOA) >= xi.mission.id.soa.LIFE_ON_THE_FRONTIER then
        player:startEvent(574)
    else
        -- Dialogue prior to joining colonization effort
        player:startEvent(506)
    end
end

return entity
