-----------------------------------
-- Area: Jugner Forest
--  NPC: Alexius
-- Involved in Quest: A purchase of Arms & Sin Hunting
-- !pos 105 1 382 104
-----------------------------------
local ID = require("scripts/zones/Jugner_Forest/IDs")
require("scripts/globals/keyitems")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getCharVar("sinHunting") == 3 then
        player:startEvent(10)
    else
        player:showText(npc, ID.text.ALEXIUS_DEFAULT)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 10 then
        player:setCharVar("sinHunting", 4)
    end
end

return entity
