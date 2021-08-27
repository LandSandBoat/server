-----------------------------------
-- Area: Phomiuna Aqueducts
--  NPC: qm_east_door_f8 (???)
-- Notes: Opens door @ F-8 from behind
-- !pos -65.512 -25.262 62.918 27
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local xPos = player:getXPos()
    local door = GetNPCByID(npc:getID() - 1)

    if xPos <= -65 and door:getAnimation() == xi.anim.CLOSE_DOOR then
        door:openDoor(15) -- _0rk
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
