-----------------------------------
-- Area: Port Jeuno
--  NPC: Garridan
--  Item Depository NPC (not implemented)
--  !pos 19.59 0 -9.9 246
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(308)
end

entity.onEventFinish = function(player, csid, option, npc)
    -- TODO: Implement
    -- Must account for race change item swaps. See http://www.playonline.com/ff11eu/envi/racechange/
end

return entity
