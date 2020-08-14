-----------------------------------
-- Area: Southern SandOria [S]
--  NPC: Laisavie X Berlends
-- !pos 26 2 6 80
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:showText(npc, 13454) -- (Couldn't find default dialogue)  How very good to see you again!
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
