-----------------------------------
-- Area: Sacrarium
--  NPC: _0s0 (Iron Gate)
-- !pos -35.026 -3.000 -9.997 28
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
