-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Dallus-Mallus
-- Type: Campaign Intel Advisor
-- !pos -13.666 -2 26.180 94
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(323)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
