-----------------------------------
-- Area: Phomiuna Aqueducts
--  NPC: qm_north_door_j9 (???)
-- Notes: Opens north door @ J-9
-- !pos 116.743 -24.636 27.518 27
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local door = GetNPCByID(npc:getID() - 2)

    if door and door:getAnimation() == xi.anim.CLOSE_DOOR then
        door:openDoor(7) -- _0ri
    end
end

return entity
