-----------------------------------
-- Area: Phomiuna Aqueducts
--  NPC: qm_east_door_f7 (???)
-- Notes: Opens east door @ F-7
-- !pos -44.550 -24.601 106.495 27
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local door = GetNPCByID(npc:getID() - 1)

    if door:getAnimation() == xi.anim.CLOSE_DOOR then
        player:startEvent(50)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 50 then
        local door = GetNPCByID(npc:getID() - 1)

        door:openDoor(7) -- _0re
    end
end

return entity
