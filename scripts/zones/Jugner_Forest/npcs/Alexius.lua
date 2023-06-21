-----------------------------------
-- Area: Jugner Forest
--  NPC: Alexius
-- Involved in Quest: A purchase of Arms & Sin Hunting
-- !pos 105 1 382 104
-----------------------------------
local ID = require("scripts/zones/Jugner_Forest/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:hasKeyItem(xi.ki.WEAPONS_ORDER) then
        player:startEvent(5)
    elseif player:getCharVar("sinHunting") == 3 then
        player:startEvent(10)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 5 then
        player:delKeyItem(xi.ki.WEAPONS_ORDER)
        player:addKeyItem(xi.ki.WEAPONS_RECEIPT)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.WEAPONS_RECEIPT)
    elseif csid == 10 then
        player:setCharVar("sinHunting", 4)
    end
end

return entity
