-----------------------------------
-- Area: Giddeus
--  NPC: Alter of Offerings
-- Involved in Quest: A Crisis in the Making
-- !pos -137 17 177 145
-----------------------------------
local ID = require("scripts/zones/Giddeus/IDs")
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
require("scripts/globals/titles")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    crisisstatus = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.A_CRISIS_IN_THE_MAKING)
    if (crisisstatus >= 1 and player:getCharVar("QuestCrisisMaking_var") == 1) then
        player:startEvent(53) -- A Crisis in the Making: Receive Offering
    else
        player:startEvent(60) -- Standard Message
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 53 and option == 1) then
        player:addKeyItem(39, tpz.ki.OFF_OFFERING)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.OFF_OFFERING)
        player:setCharVar("QuestCrisisMaking_var", 2)
    end
end
