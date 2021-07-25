-----------------------------------
-- Area: Upper Jeuno
--  NPC: Chocobo
-- Finishes Quest: Chocobo's Wounds
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if trade:hasItemQty(4545, 1) then
            player:startEvent(38)
        end
    end

entity.onTrigger = function(player, npc)
        end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    end

return entity
