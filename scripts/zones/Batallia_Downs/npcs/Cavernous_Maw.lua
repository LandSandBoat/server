-----------------------------------
-- Area: Batallia Downs
--  NPC: Cavernous Maw
-- !pos -48 0.1 435 105
-- Teleports Players to Batallia Downs [S]
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
