-----------------------------------
-- Area: Southern SandOria [S]
--  NPC: Rasdinice
-- !pos -8 1 35 80
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:showText(npc, 11637) -- (Couldn't find default text so i threw this in) Perhaps you should first attend to more pressing matters...
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
