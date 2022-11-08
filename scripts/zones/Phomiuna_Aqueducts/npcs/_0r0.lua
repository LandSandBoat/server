-----------------------------------
-- Area: Phomiuna_Aqueducts
--  NPC: _0r0 (Iron Gate)
-- !pos -140.000 -25.500 71.213 27
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if npc:getAnimation() == 9 then
        npc:openDoor()
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
