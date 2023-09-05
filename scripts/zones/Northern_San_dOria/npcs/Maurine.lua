-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Maurine
-- !pos 144.852 0.000 136.828 231
-----------------------------------
require("scripts/globals/events/starlight_celebrations")
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
