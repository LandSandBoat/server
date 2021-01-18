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
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local ratrace = player:getQuestStatus(tpz.quest.log_id.AHT_URHGAN, tpz.quest.id.ahtUrhgan.RAT_RACE)
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

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)

    if (csid == 308) then
        player:setCharVar("ratraceCS", 1)
        player:addQuest(tpz.quest.log_id.AHT_URHGAN, tpz.quest.id.ahtUrhgan.RAT_RACE)
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
            player:completeQuest(tpz.quest.log_id.AHT_URHGAN, tpz.quest.id.ahtUrhgan.RAT_RACE)
        end
    end
end

return entity
