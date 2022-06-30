-----------------------------------
-- Area: Windurst Waters
--  NPC: Cochal-Monchal
-- Involved in Quest: Dark Legacy
-- !pos -52 -6 110 238
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/keyitems")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)

    if (player:getCharVar("darkLegacyCS") == 2) then
        player:startEvent(697, 0, xi.ki.DARKSTEEL_FORMULA)
    elseif (player:getCharVar("darkLegacyCS") == 3) then
        player:startEvent(698, 0, xi.ki.DARKSTEEL_FORMULA)
    elseif (player:hasKeyItem(xi.ki.DARKSTEEL_FORMULA)) then
        player:startEvent(699, 0, xi.ki.DARKSTEEL_FORMULA)
    else
        player:startEvent(696)
    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)

    if (csid == 697) then
        player:setCharVar("darkLegacyCS", 3)
        player:delKeyItem(xi.ki.LETTER_FROM_THE_DARKSTEEL_FORGE)
    end

end

return entity
