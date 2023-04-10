-----------------------------------
-- Area: Phomiuna_Aqueducts
--  NPC: _0rb (Iron Gate)
-- !pos 180.000 -25.500 48.450 27
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
