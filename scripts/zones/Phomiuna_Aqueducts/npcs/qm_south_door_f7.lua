-----------------------------------
-- Area: Phomiuna Aqueducts
--  NPC: qm_south_door_f7 (???)
-- Notes: Open south door @ F-7
-- !pos -75.329 -24.636 92.512 27
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local door = GetNPCByID(npc:getID() - 2)

    if door:getAnimation() == xi.anim.CLOSE_DOOR then
        door:openDoor(7) -- _0rf
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
