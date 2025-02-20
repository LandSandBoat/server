-----------------------------------
-- Area: Castle Oztroja
--  NPC: _47d
-- !pos 20.000 24.168 -25.000 151
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if not player:hasKeyItem(xi.ki.OLD_RING) then
        npcUtil.giveKeyItem(player, xi.ki.OLD_RING)
    end

    if npc:getAnimation() == xi.anim.CLOSE_DOOR then
        npc:openDoor()
    end
end

return entity
