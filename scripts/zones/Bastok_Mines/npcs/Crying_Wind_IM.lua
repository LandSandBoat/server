-----------------------------------
-- Area: Bastok Mines
--  NPC: Crying Wind, I.M.
-- !pos -2 -1 -119 234
-------------------------------------
require("scripts/globals/conquest")
-------------------------------------

local guardNation = tpz.nation.BASTOK
local guardType   = tpz.conq.guard.CITY
local guardEvent  = 32761

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
