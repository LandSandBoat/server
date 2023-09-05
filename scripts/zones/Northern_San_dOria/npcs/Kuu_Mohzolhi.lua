-----------------------------------
-- Area: Northern San d'Oria
-- NPC: Kuu Mohzolhi
-- Starts and Finishes Quest: Growing Flowers
-- !pos -123 0 80 231
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if xi.events.starlightCelebration.isStarlightEnabled() ~= 0 then
        if xi.events.starlightCelebration.onStarlightSmilebringersTrade(player, trade, npc) then
            return
        end
    end
end

entity.onTrigger = function(player, npc)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
