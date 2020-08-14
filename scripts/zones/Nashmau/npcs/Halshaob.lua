-----------------------------------
-- Area: Nashmau
--  NPC: Halshaob
-- Type: Quest NPC
-- !pos 28.537 -7 -85.250 53
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(299)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
