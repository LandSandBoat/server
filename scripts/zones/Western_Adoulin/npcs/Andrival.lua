-----------------------------------
-- Area: Western Adoulin
--  NPC: Andrival
-- !pos 26 0 127 256
-----------------------------------
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local soaMission = player:getCurrentMission(xi.mission.log_id.SOA)

    if soaMission == xi.mission.id.soa.THE_MERCILESS_ONE then
        -- Reminds player to accompany Ingrid to Castle Adoulin
        player:startEvent(139)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
