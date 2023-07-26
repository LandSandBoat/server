-----------------------------------
-- Area: Spire of Vahzl
--  NPC: Radiant Aureole
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(15)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 15 and option == 1 then
        player:setPos(-379.947, 48.045, 334.059, 192, 9) -- To Pso'Xja (R)
    end
end

return entity
