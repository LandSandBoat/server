-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Arpevion, T.K.
-- !pos 105.163 0.000 -52.980 230
-------------------------------------
require("scripts/globals/conquest")
-------------------------------------

local guardNation = tpz.nation.SANDORIA
local guardType   = tpz.conq.guard.CITY
local guardEvent  = 32763

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
