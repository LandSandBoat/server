-----------------------------------
-- Area: Phomiuna_Aqueducts
--  NPC: _0r7 (Wooden Gate)
-- !pos 118.625 -25.500 20.000 27
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

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
