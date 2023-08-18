-----------------------------------
-- Area: Western Altepa Desert
--  NPC: _3h0 (Altepa Gate)
-- !pos -19 12 131 125
-----------------------------------
local ID = zones[xi.zone.WESTERN_ALTEPA_DESERT]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if npc:getAnimation() == xi.anim.CLOSE_DOOR then
        if player:getZPos() > 137 then
            npc:openDoor(3.2)
        else
            player:messageSpecial(ID.text.THE_DOOR_IS_LOCKED)
        end
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
