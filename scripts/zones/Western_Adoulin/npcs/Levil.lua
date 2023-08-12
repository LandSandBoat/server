-----------------------------------
-- Area: Western Adoulin (256)
--  NPC: Levil
-- Type: Quest and SoA Missions NPC
-- !pos -87.204 3.350 12.655 256
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- TODO:
    -- Levil has a bunch of different texts depending on where you are
    -- in the SOA missions
    -- Before Friction and Fissues day wait: cs: 127
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
