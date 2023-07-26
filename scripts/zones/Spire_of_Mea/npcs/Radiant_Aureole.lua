-----------------------------------
-- Area: Spire of Mea
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
        player:setPos(179.92, 35.15, 260.137, 64, 117)        -- To Tahrongi Canyon (R)
    end
end

return entity
