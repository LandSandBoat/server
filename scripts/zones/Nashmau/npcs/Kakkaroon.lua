-----------------------------------
-- Area: Nashmau
--  NPC: Kakkaroon
-- Standard Info NPC
-- !pos 13.245 0.000 -25.307 53
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/settings")
local ID = require("scripts/zones/Nashmau/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local ratrace = player:getQuestStatus(AHT_URHGAN, tpz.quest.id.ahtUrhgan.RAT_RACE)
    local ratRaceProg = player:getCharVar("ratraceCS")
    if (ratrace == QUEST_AVAILABLE) then
        player:startEvent(308)
    elseif (ratRaceProg == 6) then
        player:startEvent(312)
    elseif (ratrace == QUEST_ACCEPTED) then
        player:startEvent(313)

    elseif (ratrace == QUEST_COMPLETED) then
        player:startEvent(314)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 308) then
        player:setCharVar("ratraceCS", 1)
        player:addQuest(AHT_URHGAN, tpz.quest.id.ahtUrhgan.RAT_RACE)
    elseif (csid == 312) then
        if (player:getFreeSlotsCount() <= 2) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINEDX, 2187, 2)
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINEDX, 2186, 2)
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINEDX, 2185, 3)
        else
            player:setCharVar("ratraceCS", 0)
            player:addItem(2187, 2)
            player:addItem(2186, 2)
            player:addItem(2185, 3)
            player:messageSpecial(ID.text.ITEM_OBTAINEDX, 2187, 2)
            player:messageSpecial(ID.text.ITEM_OBTAINEDX, 2186, 2)
            player:messageSpecial(ID.text.ITEM_OBTAINEDX, 2185, 3)
            player:completeQuest(AHT_URHGAN, tpz.quest.id.ahtUrhgan.RAT_RACE)
        end
    end
end
