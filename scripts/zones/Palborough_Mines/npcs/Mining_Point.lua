-----------------------------------
-- Area: Palborough Mines
--  NPC: Mining Point
-----------------------------------
require("scripts/globals/helm")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if player:getCharVar("rockracketeer_sold") == 5 and math.random() < 0.25 then -- 25% chance to mine sharp stone
        if npcUtil.tradeHas(trade, xi.items.PICKAXE) then
            if math.random() < 0.75 then
                if player:getFreeSlotsCount() > 0 then
                    player:startEvent(51, 12, xi.items.SHARP_STONE) -- Sharp Stone
                else
                    player:startEvent(53) -- cannot carry any more
                end
            else
                player:startEvent(47, 8, xi.items.SHARP_STONE) -- pickaxe breaks
            end
        else
            player:startEvent(32) -- need a pickaxe
        end
    else
        xi.helm.onTrade(player, npc, trade, xi.helm.type.MINING, 120)
    end
end

entity.onTrigger = function(player, npc)
    xi.helm.onTrigger(player, xi.helm.type.MINING)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
