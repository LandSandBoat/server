-----------------------------------
-- Area: Southern San d'Oria
--  NPC: The Picture ??? in Vemalpeau's house
-- Involved in Quests: Under Oath
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/quests")
local ID = require("scripts/zones/Southern_San_dOria/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if (player:getCharVar("UnderOathCS") == 4) then  -- Quest: Under Oath - PLD AF3
        player:startEvent(41)
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 41 and option == 1) then
        player:addKeyItem(tpz.ki.STRANGE_SHEET_OF_PAPER)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.STRANGE_SHEET_OF_PAPER)
    end
end
