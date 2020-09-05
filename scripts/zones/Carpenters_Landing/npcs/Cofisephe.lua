-----------------------------------
-- Area: Carpenters' Landing
--  NPC: Cofisephe
-- Type: Adventurer's Assistant
-- !pos 210.327 -3.885 -532.511 2
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(31, 618, 652, 50, 300)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
