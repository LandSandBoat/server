-----------------------------------
-- Area: Phomiuna Aqueducts
--  NPC: qm_east_door_f7 (???)
-- Notes: Opens east door @ F-7
-- !pos -44.550 -24.601 106.495 27
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local door = GetNPCByID(npc:getID() - 1)

    if door and door:getAnimation() == xi.anim.CLOSE_DOOR then
        player:startEvent(50)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 50 then
        local door = GetNPCByID(npc:getID() - 1)

        if door then
            door:openDoor(7) -- _0re
        end
    end
end

return entity
