-----------------------------------
-- Area: Southern SandOria [S]
--  NPC: Palardaifault V Draffles
-- !pos 9 1 -35 80
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:showText(npc, 11024) -- Greetings, I am Curate Palardaifaut, and I have been assigned to the Knights of the Iron Ram to ensure that its members stray not from the path of the Goddess.
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
