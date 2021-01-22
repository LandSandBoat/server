-----------------------------------
-- Area: Southern SandOria [S]
--  NPC: Achtelle
-- !pos 108 2 -11 80
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
--player:startEvent(510);  Event doesnt work but this is her default dialogue, threw in something below til it gets fixed

    player:showText(npc, 13454) -- (Couldn't find default dialogue)  How very good to see you again!
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
