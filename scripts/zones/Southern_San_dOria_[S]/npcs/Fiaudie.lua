-----------------------------------
-- Area: Southern SandOria [S]
--  NPC: Fiaudie
-- !pos -10 1 35 80
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:showText(npc, 11054) -- (Couldn't find default text so i threw this in) So you feel there may be something amiss with our nation's current battle strategy
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
