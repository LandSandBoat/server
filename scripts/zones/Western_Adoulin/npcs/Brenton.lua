-----------------------------------
-- Area: Western Adoulin (256)
--  NPC: Brenton
-- !pos -86.036 3.349 18.121 256
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(576)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
