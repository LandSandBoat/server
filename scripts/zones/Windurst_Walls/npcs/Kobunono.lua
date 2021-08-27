-----------------------------------
-- Area: Windurst Walls
--  NPC: Kobunono
-- Type: Adv. Assistant
-- !pos 52.042 -3.499 -57.588 239
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(10005)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
