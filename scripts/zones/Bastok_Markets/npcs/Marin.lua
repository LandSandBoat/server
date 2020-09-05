-----------------------------------
-- Area: Bastok Markets
--  NPC: Marin
-- Type: Quest Giver
-- !pos -340.060 -11.003 -148.181 235
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(361)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
