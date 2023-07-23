-----------------------------------
-- Area: Temple of Uggalepih
--  NPC: Chef Nonberry
-- Type: Quest NPC
-- !pos -135.225 -1 -92.232 159
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(27)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
