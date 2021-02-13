-----------------------------------
-- Area: Nashmau
--  NPC: Fhe Maksojha
-- Type: Standard NPC
-- !pos 19.084 -7 71.287 53
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/settings")
local ID = require("scripts/zones/Nashmau/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local notmeanttobe = player:getQuestStatus(tpz.quest.log_id.AHT_URHGAN, tpz.quest.id.ahtUrhgan.NOT_MEANT_TO_BE)
    local notMeantToBeProg = player:getCharVar("notmeanttobeCS")
    if (notmeanttobe == QUEST_AVAILABLE) then
        player:startEvent(293)
    elseif (notMeantToBeProg == 1) then
        player:startEvent(295)
    elseif (notMeantToBeProg == 2) then
        player:startEvent(294)
    elseif (notMeantToBeProg == 3) then
        player:startEvent(296)
    elseif (notMeantToBeProg == 5) then
        player:startEvent(297)
    elseif (notmeanttobe == QUEST_COMPLETED) then
        player:startEvent(298)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if (csid == 293) then
        player:setCharVar("notmeanttobeCS", 1)
        player:addQuest(tpz.quest.log_id.AHT_URHGAN, tpz.quest.id.ahtUrhgan.NOT_MEANT_TO_BE)
    elseif (csid == 294) then
        player:setCharVar("notmeanttobeCS", 3)
    elseif (csid == 297) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINEDX, 2187, 3)
        else
            player:setCharVar("notmeanttobeCS", 0)
            player:addItem(2187, 3)
            player:messageSpecial(ID.text.ITEM_OBTAINEDX, 2187, 3)
            player:completeQuest(tpz.quest.log_id.AHT_URHGAN, tpz.quest.id.ahtUrhgan.NOT_MEANT_TO_BE)
        end
    end
end

return entity
