-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Jarafah
--  Item Depository NPC (not implemented)
--  !pos 14.88 0 -15 50
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(702)
end

entity.onEventFinish = function(player, csid, option, npc)
    -- TODO: Implement
    -- Must account for race change item swaps. See http://www.playonline.com/ff11eu/envi/racechange/
end

return entity
