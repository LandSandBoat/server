-----------------------------------
-- Area: Mhaura
--  NPC: Vera
-- Finishes Quest: The Old Lady
-- !pos -49 -5 20 249
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/settings")
require("scripts/globals/quests")
local ID = require("scripts/zones/Mhaura/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local questStatus = player:getQuestStatus(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.THE_OLD_LADY)

    if questStatus == QUEST_ACCEPTED and trade:getItemCount() == 1 then
        local veraOldLadyVar = player:getCharVar("VeraOldLadyVar")

        if veraOldLadyVar == 1 and trade:hasItemQty(542, 1) then
            player:startEvent(135, 541)
        elseif veraOldLadyVar == 2 and trade:hasItemQty(541, 1) then
            player:startEvent(136, 540)
        elseif veraOldLadyVar == 3 and trade:hasItemQty(540, 1) then
            player:startEvent(137)
        end
    end
end

entity.onTrigger = function(player, npc)
    local questStatus = player:getQuestStatus(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.THE_OLD_LADY)

    if player:getQuestStatus(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.ELDER_MEMORIES) ~= QUEST_AVAILABLE then
        player:startEvent(130)
    elseif questStatus == QUEST_COMPLETED then
        player:startEvent(138)
    elseif questStatus == QUEST_ACCEPTED then
        local veraOldLadyVar = player:getCharVar("VeraOldLadyVar")

        if player:hasKeyItem(xi.ki.GILGAMESHS_INTRODUCTORY_LETTER) then
            player:startEvent(137)
        elseif veraOldLadyVar == 1 then
            player:startEvent(132, 542)
        elseif veraOldLadyVar == 2 then
            player:startEvent(132, 541)
        elseif veraOldLadyVar == 3 then
            player:startEvent(132, 540)
        end
    else
        if player:getMainLvl() >= xi.settings.main.SUBJOB_QUEST_LEVEL then
            player:startEvent(131, 542)
        else
            player:startEvent(133)
        end
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 131 and option == 40 then
        player:addQuest(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.THE_OLD_LADY)
        player:setCharVar("VeraOldLadyVar", 1)
    elseif csid == 135 then
        player:tradeComplete()
        player:setCharVar("VeraOldLadyVar", 2)
    elseif csid == 136 then
        player:tradeComplete()
        player:setCharVar("VeraOldLadyVar", 3)
    elseif csid == 137 then
        player:tradeComplete()
        player:unlockJob(0)
        player:setCharVar("VeraOldLadyVar", 0)
        player:messageSpecial(ID.text.SUBJOB_UNLOCKED)
        player:completeQuest(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.THE_OLD_LADY)
    end
end

return entity
