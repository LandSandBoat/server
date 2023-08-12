-----------------------------------
-- Area: Ro'Maeve
--  NPC: _3e1 (Moongate)
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
    if player:hasKeyItem(xi.ki.MOONGATE_PASS) then
        npc:openDoor(10)
    end
end

entity.onTrade = function(player, npc, trade)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
