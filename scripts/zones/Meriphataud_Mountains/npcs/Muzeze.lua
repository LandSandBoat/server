-----------------------------------
-- Area: Meriphataud Mountains
--  NPC: Muzeze
-- Type: Armor Storer
-- !pos -6.782 -18.428 208.185 119
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(44)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
