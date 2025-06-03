-----------------------------------
-- Area: Phomiuna Aqueducts
--  NPC: qm_south_door_f7 (???)
-- Notes: Open south door @ F-7
-- !pos -75.329 -24.636 92.512 27
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local door = GetNPCByID(npc:getID() - 2)

    if door and door:getAnimation() == xi.anim.CLOSE_DOOR then
        player:startEvent(51)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 51 then
        local door = GetNPCByID(npc:getID() - 2)

        if door then
            door:openDoor(7) -- _0rf
        end
    end
end

return entity
