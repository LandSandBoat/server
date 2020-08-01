-----------------------------------
-- Area: Carpenters' Landing
--  NPC: Coupulie
-- Type: Standard NPC
-- !pos -313.585 -3.628 490.944 2
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(32, 618, 652, 50, 300)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
