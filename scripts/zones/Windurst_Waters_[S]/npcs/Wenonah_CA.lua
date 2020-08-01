-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Wenonah, C.A.
-- Type: Campaign Arbiter
-- !pos -2.175 -2 10.184 94
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(459)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
