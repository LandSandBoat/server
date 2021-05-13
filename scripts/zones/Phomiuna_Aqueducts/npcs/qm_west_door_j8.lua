-----------------------------------
-- Area: Phomiuna Aqueducts
--  NPC: qm_west_door_j8 (???)
-- Notes: Opens door @ J-8 from behind
-- !pos 105.502 -25.262 57.138 27
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local xPos = player:getXPos()
    local door = GetNPCByID(npc:getID() - 1)

    if xPos > 105 and door:getAnimation() == xi.anim.CLOSE_DOOR then
        door:openDoor(7) -- _0rl
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
