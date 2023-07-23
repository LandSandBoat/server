-----------------------------------
-- Area: Sacrarium
--  NPC: _0s3 (Wooden Gate)
-- !pos 100.000 -3.500 97.370 28
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
    if npc:getAnimation() == 9 then
        npc:openDoor()
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
