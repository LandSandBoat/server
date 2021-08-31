-----------------------------------
-- Area: Wajaom Woodlands
--  NPC: Engraved Tablet
-- !pos 233 -9 -634 51
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(515)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
