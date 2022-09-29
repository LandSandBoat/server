-----------------------------------
-- Area: Metalworks
--  NPC: Mighty Fist
-- Involved in Quest: Dark Legacy
-- !pos -47 2 -30 237
-----------------------------------
require("scripts/globals/keyitems")
local ID = require("scripts/zones/Metalworks/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getCharVar("darkLegacyCS") == 1 then
        player:startEvent(752)
    elseif player:hasKeyItem(xi.ki.DARKSTEEL_FORMULA) then
        player:startEvent(754)
    else
        local randMessage = math.random(0, 1)

        if randMessage == 1 then
            player:startEvent(560)
        else
            player:startEvent(561)
        end
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if (csid == 752) then
        player:setCharVar("darkLegacyCS", 2)
        player:addKeyItem(xi.ki.LETTER_FROM_THE_DARKSTEEL_FORGE)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.LETTER_FROM_THE_DARKSTEEL_FORGE)
    end
end

return entity
