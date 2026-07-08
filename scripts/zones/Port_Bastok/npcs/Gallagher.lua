-----------------------------------
-- Area: Port Bastok
--  NPC: Gallagher
--  Item Depository NPC (not implemented)
--  !pos -33 7.5 -179 236
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(349)
end

entity.onEventFinish = function(player, csid, option, npc)
    -- TODO: Implement
    -- Must account for race change item swaps. See http://www.playonline.com/ff11eu/envi/racechange/
end

return entity
