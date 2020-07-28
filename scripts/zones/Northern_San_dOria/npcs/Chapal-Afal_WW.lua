-----------------------------------
-- Area: Northern Sand Oria
--  NPC: Chapal-Afal, W.W.
-- !pos -55 -2 31 231
-------------------------------------
require("scripts/globals/conquest")
-------------------------------------

local guardNation = tpz.nation.WINDURST
local guardType   = tpz.conq.guard.FOREIGN
local guardEvent  = 32759

function onTrade(player, npc, trade)
    tpz.conq.overseerOnTrade(player, npc, trade, guardNation, guardType)
end

function onTrigger(player, npc)
    tpz.conq.overseerOnTrigger(player, npc, guardNation, guardType, guardEvent)
end

function onEventUpdate(player, csid, option)
    tpz.conq.overseerOnEventUpdate(player, csid, option, guardNation)
end

function onEventFinish(player, csid, option)
    tpz.conq.overseerOnEventFinish(player, csid, option, guardNation, guardType)
end
