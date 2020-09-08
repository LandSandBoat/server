-----------------------------------
-- Area: Southern SandOria [S]
--  NPC: Cerane I Virgaut
-- !pos -268 -4 100 80
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
