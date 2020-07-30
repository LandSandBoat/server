-----------------------------------
-- Area: Gusgen Mines
--  NPC: Strange Apparatus
-- !pos 219 -39 255 196
-----------------------------------
require("scripts/globals/strangeapparatus")
-----------------------------------

function onTrade(player, npc, trade)
    tpz.strangeApparatus.onTrade(player, trade, 2)
end

function onTrigger(player, npc)
    tpz.strangeApparatus.onTrigger(player, 0)
end

function onEventUpdate(player, csid, option)
    if csid == 0 then
        tpz.strangeApparatus.onEventUpdate(player, option)
    end
end

function onEventFinish(player, csid, option)
    if csid == 2 then
        tpz.strangeApparatus.onEventFinish(player)
    end
end
