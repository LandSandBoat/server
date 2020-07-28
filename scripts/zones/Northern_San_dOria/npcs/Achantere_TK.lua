-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Achatere, T.K.
-------------------------------------
require("scripts/globals/conquest")
-------------------------------------

local guardNation = tpz.nation.SANDORIA
local guardType   = tpz.conq.guard.CITY
local guardEvent  = 32762

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
