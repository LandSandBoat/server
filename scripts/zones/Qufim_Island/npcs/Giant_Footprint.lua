-----------------------------------
-- Area: Qufim Island
--  NPC: Giant Footprint
-- Involved in quest: Regaining Trust
-- !pos 501 -11 354 126
-----------------------------------
local ID = zones[xi.zone.QUFIM_ISLAND]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.GIGANTIC_FOOTPRINT)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
