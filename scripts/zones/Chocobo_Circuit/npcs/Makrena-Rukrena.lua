-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Makrena-Rukrena
-- Standard Info NPC
-- pos - -17.9971 -13.0000 -114.2916
-- event 368 369 370
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(368)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
