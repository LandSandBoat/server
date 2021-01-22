-----------------------------------
-- Area: Southern SandOria [S]
--  NPC: Kilhwch
-- !pos -63 2 -50 80
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:showText(npc, 11143) -- I advise you distance yourself from Lady Ulla. I know not your intentions, but am inclined to believe they are crooked
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
