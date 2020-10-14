-----------------------------------
-- Area: Garlaige Citadel
--  NPC: qm6 (???)
-- Involved in Quest: Hitting the Marquisate (THF AF3)
-- !pos -220.039 -5.500 194.192 200
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/keyitems")
local ID = require("scripts/zones/Garlaige_Citadel/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.PRESENCE_FROM_CEILING)
    if
        player:hasKeyItem(tpz.ki.BOMB_INCENSE) and
        player:getCharVar("hittingTheMarquisateHagainCS") == 2
    then
        player:startEvent(50, tpz.keyItem.BOMB_INCENSE)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 50 and option == 1 then
        player:setCharVar("hittingTheMarquisateHagainCS", 3)
    end
end
