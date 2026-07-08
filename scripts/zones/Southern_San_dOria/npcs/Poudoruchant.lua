-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Poudoruchant
--  Item Depository NPC (not implemented)
--  !pos -139.56 -2 21.31 230
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(779)
end

entity.onEventFinish = function(player, csid, option, npc)
    -- TODO: Implement
    -- Must account for race change item swaps. See http://www.playonline.com/ff11eu/envi/racechange/
end

return entity
