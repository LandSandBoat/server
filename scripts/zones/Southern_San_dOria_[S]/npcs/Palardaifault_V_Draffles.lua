-----------------------------------
-- Area: Southern SandOria [S]
--  NPC: Palardaifault V Draffles
-- !pos 9 1 -35 80
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:showText(npc, 11024) -- Greetings, I am Curate Palardaifaut, and I have been assigned to the Knights of the Iron Ram to ensure that its members stray not from the path of the Goddess.
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
