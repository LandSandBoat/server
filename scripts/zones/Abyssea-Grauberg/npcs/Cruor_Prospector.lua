-----------------------------------
-- Area: Abyssea - Grauberg
--  NPC: Cruor Prospector
-- Type: Cruor NPC
-- !pos -528 26 -782 254
-----------------------------------
require("scripts/globals/abyssea")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local cruor = player:getCurrency("cruor")
    local demilune = tpz.abyssea.getDemiluneAbyssite(player)
    player:startEvent(2002, cruor, demilune)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
