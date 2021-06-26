-----------------------------------
-- Area: Lower Jeuno
--  NPC: Muckvix
-- Involved in Mission: Magicite
-- !pos -26.824 3.601 -137.082 245
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/zone")
local ID = require("scripts/zones/Lower_Jeuno/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- To be deprecated by M4-1 Interaction Conversions
    if player:getNation() ~= xi.nation.SANDORIA then
        if player:hasKeyItem(xi.ki.SILVER_BELL) and not player:hasKeyItem(xi.ki.YAGUDO_TORCH) then
            if player:getCharVar("YagudoTorchCS") == 1 then
                player:startEvent(184)
            else
                player:startEvent(80)
            end
        elseif player:getCurrentMission(player:getNation()) == xi.mission.id.nation.MAGICITE then
            if player:getCharVar("FickblixCS") == 1 then
                player:startEvent(81)
            else
                player:startEvent(79)
            end
        end
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    -- To be deprecated by M4-1 Interaction Conversions
    if player:getNation() ~= xi.nation.SANDORIA then
        if csid == 184 then
            player:addKeyItem(xi.ki.YAGUDO_TORCH)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.YAGUDO_TORCH)
            player:setCharVar("YagudoTorchCS", 0)
            player:setCharVar("FickblixCS", 1)
        end
    end
end

return entity
