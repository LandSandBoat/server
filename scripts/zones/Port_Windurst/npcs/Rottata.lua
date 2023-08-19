-----------------------------------
-- Area: Port Windurst
--  NPC: Rottata
-- Outpost Teleporter NPC
-- !pos 193.111 -12.999 215.638 240
-----------------------------------
local entity = {}

local teleporterNation = xi.nation.WINDURST
local teleporterEvent  = 552

entity.onTrigger = function(player, npc)
    xi.conquest.teleporterOnTrigger(player, teleporterNation, teleporterEvent)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.conquest.teleporterOnEventUpdate(player, csid, option, teleporterEvent)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.conquest.teleporterOnEventFinish(player, csid, option, teleporterEvent)
end

return entity
