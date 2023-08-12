-----------------------------------
-- Area: Phomiuna_Aqueducts
--  NPC: _0r8 (Ornate Gate)
-- !pos 129.500 -25.500 60.000 27
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
