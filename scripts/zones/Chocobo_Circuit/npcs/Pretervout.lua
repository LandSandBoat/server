-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Pretervout
-- Standard Info NPC
-- pos -259.2362 -4.0000 -454.5314
-- event 267 268 269 270 271 275 279 283 
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(267)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
