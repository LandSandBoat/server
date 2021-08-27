-----------------------------------
-- Area: Upper Jeuno
--  NPC: Paya-Sabya
-- Involved in Mission: Magicite
-- !pos 9 1 70 244
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/zone")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- To be deprecated by M4-1 Interaction Conversions
    if player:getNation() ~= xi.nation.SANDORIA then
        if player:hasKeyItem(xi.ki.SILVER_BELL) and not player:hasKeyItem(xi.ki.YAGUDO_TORCH) and player:getCharVar("YagudoTorchCS") == 0 then
            player:startEvent(80)
        end
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    -- To be deprecated by M4-1 Interaction Conversions
    if csid == 80 and player:getNation() ~= xi.nation.SANDORIA then
        player:setCharVar("YagudoTorchCS", 1)
    end
end

return entity
