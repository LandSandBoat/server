-----------------------------------
-- Area: Abdhaljs Isle-Purgonorgo
--  NPC: Pursuivant
-- Type: Warp
-- !pos 516.223 -3.038 545.258 44
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(3)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 3 and option == 1 then
        player:setPos(-0.135, 0.000, 22.880, 105, 244)
    end
end

return entity
