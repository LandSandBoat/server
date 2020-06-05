-----------------------------------
-- Area: Batallia Downs [S]
--  NPC: Cavernous Maw
-- !pos -48 0 435 84
-- Teleports Players to Batallia Downs
-----------------------------------
require("scripts/globals/maws")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    tpz.maws.onTrigger(player, npc)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    tpz.maws.onEventFinish(player, csid, option)
end
