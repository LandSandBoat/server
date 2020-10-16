-----------------------------------
-- Area: Garlaige Citadel
--  NPC: qm12 (???)
-- Involved in Quest: Hitting the Marquisate (THF AF3)
-- !pos -245.603 -5.500 139.855 200
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/keyitems")
local ID = require("scripts/zones/Garlaige_Citadel/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:hasKeyItem(tpz.ki.BOMB_INCENSE) and player:getCharVar("hittingTheMarquisateHagainCS") == 4 then
        player:messageSpecial(ID.text.PRESENCE_FROM_CEILING)
        player:startEvent(52, tpz.keyItem.BOMB_INCENSE)
    else
        player:messageSpecial(ID.text.HOLE_IN_THE_CEILING) -- Default
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 52 and option == 1 then
        player:messageSpecial(ID.text.THE_PRESENCE_MOVES) -- Presence moved east.
        player:setCharVar("hittingTheMarquisateHagainCS", 5)
    end
end
