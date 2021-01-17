-----------------------------------
-- Area: Upper Jeuno
--  NPC: Paya-Sabya
-- Involved in Mission: Magicite
-- !pos 9 1 70 244
-----------------------------------
require("scripts/globals/keyitems")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)

    if (player:hasKeyItem(tpz.ki.SILVER_BELL) and player:hasKeyItem(tpz.ki.YAGUDO_TORCH) == false and player:getCharVar("YagudoTorchCS") == 0) then
        player:startEvent(80)
    else
        player:startEvent(79)
    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)

    if (csid == 80) then
        player:setCharVar("YagudoTorchCS", 1)
    end

end

return entity
