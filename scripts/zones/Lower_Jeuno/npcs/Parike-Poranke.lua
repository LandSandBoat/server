-----------------------------------
-- Area: Lower Jeuno
--  NPC: Parike-Poranke
-- Type: Adventurer's Assistant
-- !pos -33.161 -1 -61.303 245
-----------------------------------
local ID = zones[xi.zone.LOWER_JEUNO]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.PARIKE_PORANKE_DIALOG)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
