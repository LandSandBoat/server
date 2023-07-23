-----------------------------------
-- Area: Spire of Holla
--  NPC: Radiant Aureole
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(14)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 14 and option == 1 then
        player:setPos(340.082, 19.103, -59.979, 127, 102)     -- To La Theine Plateau (R)
    end
end

return entity
