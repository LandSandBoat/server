-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Baraka
-- Involved in Missions 2-3
-- !pos 36 -2 -2 231
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
        local pNation = player:getNation()

    if pNation == xi.nation.SANDORIA then
            player:startEvent(580)
    elseif pNation == xi.nation.WINDURST then
            player:startEvent(579)
        else
            player:startEvent(539)
        end
    end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
        end

return entity
