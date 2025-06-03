-----------------------------------
-- Area: Ru'Lude Gardens
--  NPC: Audience Chamber
-- Involved in Mission: Magicite
-- !pos 0 -5 66 243
-----------------------------------
local ID = zones[xi.zone.RULUDE_GARDENS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:hasKeyItem(xi.ki.ARCHDUCAL_AUDIENCE_PERMIT) then
        player:messageSpecial(ID.text.SOVEREIGN_WITHOUT_AN_APPOINTMENT)
    else
        player:startEvent(138) -- you don't have a permit
    end
end

return entity
