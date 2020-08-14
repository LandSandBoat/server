-----------------------------------
-- Area: Bastok Mines
--  NPC: Conrad
-- Outpost Teleporter NPC
-- !pos 94.457 -0.375 -66.161 234
-----------------------------------
require("scripts/globals/conquest")
-----------------------------------

local teleporterNation = tpz.nation.BASTOK
local teleporterEvent  = 581

function onTrigger(player, npc)
    tpz.conquest.teleporterOnTrigger(player, teleporterNation, teleporterEvent)
end

function onEventUpdate(player, csid, option)
    tpz.conquest.teleporterOnEventUpdate(player, csid, option, teleporterEvent)
end

function onEventFinish(player, csid, option)
    tpz.conquest.teleporterOnEventFinish(player, csid, option, teleporterEvent)
end
