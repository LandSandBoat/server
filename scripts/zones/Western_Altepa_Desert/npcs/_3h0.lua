-----------------------------------
-- Area: Western Altepa Desert
--  NPC: _3h0 (Altepa Gate)
-- !pos -19 12 131 125
-----------------------------------
local ID = zones[xi.zone.WESTERN_ALTEPA_DESERT]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if npc:getAnimation() == xi.anim.CLOSE_DOOR then
        if player:getZPos() > 137 then
            npc:openDoor(3.2)
        else
            player:messageSpecial(ID.text.THE_DOOR_IS_LOCKED)
        end
    end
end

return entity
