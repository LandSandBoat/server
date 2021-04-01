-----------------------------------
-- Area: Mhaura
--  NPC: Take
-- Involved In Quest: RYCHARDE_THE_CHEF
--  Starts and finishes quest: Expertice
-----------------------------------
require("scripts/globals/titles")
require("scripts/globals/quests")
require("scripts/globals/settings")
local ID = require("scripts/zones/Mhaura/IDs")
-----------------------------------
local entity = {}

-- player:startEvent(59) -- standar dialog
-- player:startEvent(60) -- tell to look for ricarde
--player:startEvent(68) -- not talked to rycharde yet
--player:startEvent(61)-- accept expertice quest
--player:startEvent(62)-- expertice completed
--player:startEvent(63)-- expertice not done yet
--player:startEvent(64) -- after expertice quest
--player:startEvent(65) -- good luck
--player:startEvent(66)-- Valgeir cook was delicious
--player:startEvent(67)-- after back to basics i think

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)

    if (player:getQuestStatus(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.RYCHARDE_THE_CHEF)==QUEST_AVAILABLE) then -- if available and allready talked to mayor assistant
        if (player:getCharVar("QuestRychardetheChef_var") == 1) then
            player:startEvent(60) -- tell to look for ricarde
        elseif (player:getCharVar("QuestRychardetheChef_var") == 2) then
            player:startEvent(68) -- not talked to rycharde yet
        else
            player:startEvent(59) -- talk abaout something else
        end


    elseif (player:getQuestStatus(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.EXPERTISE)==QUEST_AVAILABLE and player:getQuestStatus(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.HIS_NAME_IS_VALGEIR )==QUEST_COMPLETED) then --
        player:startEvent(61)-- accept expertice quest


    elseif (player:getQuestStatus(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.EXPERTISE)==QUEST_ACCEPTED) then --
        if (player:hasKeyItem(xi.ki.LAND_CRAB_BISQUE)) then -- if have the Land Crab Bisque from Valgeir
            player:startEvent(62, 132)-- expertice completed
        else
            player:startEvent(63)-- expertice not done yet
        end

    elseif (player:getQuestStatus(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.EXPERTISE)==QUEST_COMPLETED and player:getQuestStatus(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.THE_CLUE)==QUEST_AVAILABLE) then --
        player:startEvent(64) -- after expertice quest
    elseif (player:getQuestStatus(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.THE_CLUE)==QUEST_ACCEPTED) then--
        player:startEvent(65) -- good luck
    elseif (player:getQuestStatus(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.THE_CLUE)==QUEST_COMPLETED and player:getQuestStatus(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.THE_BASICS)==QUEST_AVAILABLE) then --
        player:startEvent(66)-- Valgeir cook was delicious
    elseif (player:getQuestStatus(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.THE_BASICS)==QUEST_COMPLETED) then--
        player:startEvent(67)-- after back to basics i think
    else
        player:startEvent(59) -- talk abaout something else
    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if (csid == 60) then
        player:setCharVar("QuestRychardetheChef_var", 2) -- second stage on quest
    elseif (csid == 61) then  -- accept quest EXPERTICE
        player:addQuest(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.EXPERTISE)
    elseif (csid == 62) then   -- end quest expertice
        player:addFame(WINDURST, 120)
        if (player:getFreeSlotsCount() < 1) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 132)
        else
            player:addItem(132)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 132)
            player:addTitle(xi.title.THREESTAR_PURVEYOR)
            player:setCharVar("QUEST_EXPERTISE_STATE_var", 0) --done cooking
            player:setCharVar("QuestHNIVCCompDay_var", 0) -- completition day of unending chase
            player:setCharVar("QuestHNIVCCompYear_var", 0)
            player:setCharVar("QuestExpertiseCompDay_var", VanadielDayOfTheYear()) -- completition day of expertise quest
            player:setCharVar("QuestExpertiseCompYear_var", VanadielYear())
            player:delKeyItem(xi.ki.LAND_CRAB_BISQUE) --give Land Crab Bisque from Valgeir
            player:completeQuest(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.EXPERTISE)
        end
    end
end

return entity
