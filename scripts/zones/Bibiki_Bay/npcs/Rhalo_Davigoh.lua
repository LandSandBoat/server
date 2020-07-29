-----------------------------------
-- Area: Bibiki Bay
--  NPC: Rhalo Davigoh
-- !pos -407 -3 -419 4
-----------------------------------
require("scripts/globals/shop")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(38)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
