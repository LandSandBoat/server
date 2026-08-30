-----------------------------------
-- Area: Castle Oztroja
--  NPC: _47d
-- !pos 20.000 24.168 -25.000 151
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if npc:getAnimation() == xi.animation.CLOSE_DOOR then
        npc:openDoor()
    end

    if not player:hasKeyItem(xi.ki.OLD_RING) then
        return player:startEvent(44, 0, xi.ki.OLD_RING)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 44 then
        npcUtil.giveKeyItem(player, xi.ki.OLD_RING)
    end
end

return entity
