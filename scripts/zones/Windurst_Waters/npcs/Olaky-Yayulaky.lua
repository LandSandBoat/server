-----------------------------------
-- Area: Windurst Waters
--  NPC: Olaky-Yayulaky
--  Item Depository NPC (not implemented)
--  !pos -60 -3.5 71 238
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(910)
end

entity.onEventFinish = function(player, csid, option, npc)
    -- TODO: Implement
    -- Must account for race change item swaps. See http://www.playonline.com/ff11eu/envi/racechange/
end

return entity
