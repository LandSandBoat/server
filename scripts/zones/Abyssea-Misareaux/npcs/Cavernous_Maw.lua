-----------------------------------
-- Area: Abyssea - Misareaux
--  NPC: Cavernous Maw
-- !pos 676.070, -16.063, 318.999 216
-- Teleports Players to Valkrum Dunes
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(200)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 200 and option == 1 then
        player:setPos(362, 0.001, -119, 4, 103)
    end
end

return entity
