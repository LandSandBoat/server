-----------------------------------
-- Area: Qulun Dome
--  NPC: Door
-- Involved in Mission: Limit Break 3
-- !pos 299.999 37.864 47.067 148
-----------------------------------
local ID = zones[xi.zone.QULUN_DOME]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if npc:getAnimation() == 9 then
        if player:getZPos() < 46 then
            if
                player:hasKeyItem(xi.ki.SILVER_BELL) and
                player:hasKeyItem(xi.ki.CORUSCANT_ROSARY) and
                player:hasKeyItem(xi.ki.BLACK_MATINEE_NECKLACE)
            then
                player:messageSpecial(ID.text.THE_3_ITEMS_GLOW_FAINTLY, xi.ki.SILVER_BELL, xi.ki.CORUSCANT_ROSARY, xi.ki.BLACK_MATINEE_NECKLACE)
                npc:openDoor(20) -- retail timed
            else
                player:messageSpecial(ID.text.IT_SEEMS_TO_BE_LOCKED_BY_POWERFUL_MAGIC)
            end
        else
            player:messageSpecial(ID.text.CANNOT_BE_OPENED_FROM_THIS_SIDE)
        end
    end
end

return entity
