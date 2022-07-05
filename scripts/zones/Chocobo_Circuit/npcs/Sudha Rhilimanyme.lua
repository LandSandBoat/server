-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Sudha Rhilimanyme
-- Standard Info NPC
-- pos -264.7245 -4.0000 -454.0705
-- event 267 271 272 273 274 275 283
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
