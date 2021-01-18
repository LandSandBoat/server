-----------------------------------
-- Area: Garlaige Citadel
--  NPC: qm10 (???)
-- Involved in Quest: Hitting the Marquisate (THF AF3)
-- !pos -139.895 -5.500 154.513 200
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/keyitems")
local ID = require("scripts/zones/Garlaige_Citadel/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:hasKeyItem(tpz.ki.BOMB_INCENSE) and player:getCharVar("hittingTheMarquisateHagainCS") == 6 then
        player:messageSpecial(ID.text.PRESENCE_FROM_CEILING)
        player:startEvent(54, tpz.keyItem.BOMB_INCENSE)
    else
        player:messageSpecial(ID.text.HOLE_IN_THE_CEILING) -- Default
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 54 and option == 1 then
        player:messageSpecial(ID.text.THE_PRESENCE_MOVES + 3) -- Presence moved north.
        player:setCharVar("hittingTheMarquisateHagainCS", 7)
    end
end

return entity
