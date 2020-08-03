-----------------------------------
-- Area: The Shrine of Ru'Avitau
--  NPC: Treasure Casket
-----------------------------------
require("scripts/globals/caskets")
-----------------------------------

function onTrigger(player, npc)
    tpz.caskets.onTrigger(player, npc)
end

function onTrade(player, npc, trade)
    tpz.caskets.onTrade(player, npc, trade)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    tpz.caskets.onEventFinish(player, csid, option)
end
