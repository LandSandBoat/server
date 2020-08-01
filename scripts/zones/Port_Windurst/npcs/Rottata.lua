-----------------------------------
-- Area: Port Windurst
--  NPC: Rottata
-- Outpost Teleporter NPC
-- !pos 193.111 -12.999 215.638 240
-----------------------------------
require("scripts/globals/conquest")
-----------------------------------

local teleporterNation = tpz.nation.WINDURST
local teleporterEvent  = 552

function onTrigger(player, npc)
    tpz.conquest.teleporterOnTrigger(player, teleporterNation, teleporterEvent)
end

function onEventUpdate(player, csid, option)
    tpz.conquest.teleporterOnEventUpdate(player, csid, option, teleporterEvent)
end

function onEventFinish(player, csid, option)
    tpz.conquest.teleporterOnEventFinish(player, csid, option, teleporterEvent)
end
