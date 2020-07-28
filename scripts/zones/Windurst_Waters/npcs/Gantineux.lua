-----------------------------------
-- Area: Windurst Waters
--  NPC: Gantineux
-- Starts Quest: Acting in Good Faith
-- !pos -83 -9 3 238
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/shop")
require("scripts/globals/quests")
local ID = require("scripts/zones/Windurst_Waters/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    ActingInGoodFaith = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.ACTING_IN_GOOD_FAITH)

    if (ActingInGoodFaith == QUEST_AVAILABLE and player:getFameLevel(WINDURST) >= 4 and player:getMainLvl() >= 10) then
        player:startEvent(10019) -- Start quest "Acting in Good Faith"
    elseif (ActingInGoodFaith == QUEST_ACCEPTED) then
        if (player:hasKeyItem(tpz.ki.SPIRIT_INCENSE) == true) then
            player:startEvent(10020) -- During quest "Acting in Good Faith" (with Spirit Incense KI)
        elseif (player:hasKeyItem(tpz.ki.GANTINEUXS_LETTER) == true) then
            player:startEvent(10022) --  During quest "Acting in Good Faith" (with Gantineux's Letter)
        else
            player:startEvent(10021) -- During quest "Acting in Good Faith" (before Gantineux's Letter)
        end
    elseif (ActingInGoodFaith == QUEST_COMPLETED) then
        player:startEvent(10023) -- New standard dialog after "Acting in Good Faith"
    else
        player:startEvent(10018) -- Standard dialog
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 10019 and option == 0) then
        player:addQuest(WINDURST, tpz.quest.id.windurst.ACTING_IN_GOOD_FAITH)
        player:addKeyItem(tpz.ki.SPIRIT_INCENSE)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.SPIRIT_INCENSE)
    elseif (csid == 10021) then
        player:addKeyItem(tpz.ki.GANTINEUXS_LETTER)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.GANTINEUXS_LETTER)
    end
end
