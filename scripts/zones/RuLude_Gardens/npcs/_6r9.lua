-----------------------------------
-- Area: Ru'Lude Gardens
--  NPC: Audience Chamber
-- Involved in Mission: Magicite
-- !pos 0 -5 66 243
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    -- Param 0 picks between the guards turning the player away and the no permit line.
    if player:hasKeyItem(xi.ki.ARCHDUCAL_AUDIENCE_PERMIT) then
        player:startEvent(138, 1)
    else
        player:startEvent(138, 0)
    end
end

return entity
