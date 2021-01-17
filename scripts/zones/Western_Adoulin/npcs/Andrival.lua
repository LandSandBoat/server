-----------------------------------
-- Area: Western Adoulin
--  NPC: Andrival
-- Type: Standard NPC
-- !pos 26 0 127 256
-----------------------------------
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local SOA_Mission = player:getCurrentMission(SOA)

    if (SOA_Mission == tpz.mission.id.soa.THE_MERCILESS_ONE) then
        -- Reminds player to accompany Ingrid to Castle Adoulin
        player:startEvent(139)
    else
        -- Standard dialogue
        player:startEvent(552)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
