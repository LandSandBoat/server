-----------------------------------
-- Area: Valkurm Dunes
--  NPC: Stone Monument
-- Involved in quest "An Explorer's Footsteps"
-- !pos -311.299 -4.420 -138.878 103
-----------------------------------
local ID = zones[xi.zone.VALKURM_DUNES]
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(900)
end

entity.onTrade = function(player, npc, trade)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
