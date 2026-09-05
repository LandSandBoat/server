-----------------------------------
-- Area: Ru'Lude Gardens
--  NPC: Rainhard
-- Involved in Mission: Magicite
-- !pos -2.397 -4.999 68.749 243
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    -- Param 0 picks between waving the player through and asking for the permit.
    if player:hasKeyItem(xi.ki.ARCHDUCAL_AUDIENCE_PERMIT) then
        player:startEvent(165, 1)
    else
        player:startEvent(165, 0)
    end
end

return entity
