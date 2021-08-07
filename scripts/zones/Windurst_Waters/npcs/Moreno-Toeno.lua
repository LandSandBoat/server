-----------------------------------
-- Area: Windurst Waters
--  NPC: Moreno-Toeno
-- Starts and Finishes Quest: Teacher's Pet
-- !pos 169 -1.25 159 238
-----------------------------------
local ID = require("scripts/zones/Windurst_Waters/IDs")
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/quests")
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if (player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.TEACHER_S_PET) >= 1 and trade:hasItemQty(847, 1) == true and trade:hasItemQty(4368, 1) == true and trade:getGil() == 0 and trade:getItemCount() == 2) then
        player:startEvent(440, 250, 847, 4368) -- -- Quest Finish
    end
end

entity.onTrigger = function(player, npc)

    local teacherstatus = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.TEACHER_S_PET)

    if (player:getCurrentMission(WINDURST) == xi.mission.id.windurst.VAIN and player:getMissionStatus(player:getNation()) == 0) then
        player:startEvent(752, 0, xi.ki.STAR_SEEKER)
    elseif (player:getCurrentMission(WINDURST) == xi.mission.id.windurst.VAIN and player:getMissionStatus(player:getNation()) >= 1) then
        if (player:getMissionStatus(player:getNation()) < 4) then
            player:startEvent(753)
        elseif (player:getMissionStatus(player:getNation()) == 4) then
            player:startEvent(758)
        end
    elseif (teacherstatus == QUEST_AVAILABLE) then
        local prog = player:getCharVar("QuestTeachersPet_prog")
        if (prog == 0) then
            player:startEvent(437) -- Before Quest
            player:setCharVar("QuestTeachersPet_prog", 1)
        elseif (prog == 1) then
            player:startEvent(438, 0, 847, 4368) -- Quest Start
        end
    elseif (teacherstatus == QUEST_ACCEPTED) then
        player:startEvent(439, 0, 847, 4368) -- Quest Reminder
    elseif (player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.MAKING_THE_GRADE) == QUEST_ACCEPTED) then
        player:startEvent(444) -- During Making the GRADE
    else   --  Will run through these iffame is not high enough for other quests
        local rand = math.random(1, 2)
        if (rand == 1) then
            player:startEvent(441) -- Standard Conversation 1
        else
            player:startEvent(469) -- Standard Conversation 2
        end
    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)

    if (csid == 438 and option == 0) then
        player:addQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.TEACHER_S_PET)
    elseif (csid == 438 and option == 1) then
        player:setCharVar("QuestTeachersPet_prog", 0)
    elseif (csid == 440) then
        player:addGil(xi.settings.GIL_RATE*250)
        player:setCharVar("QuestTeachersPet_prog", 0)
        player:tradeComplete()
        if (player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.TEACHER_S_PET) == QUEST_ACCEPTED) then
            player:completeQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.TEACHER_S_PET)
            player:addFame(WINDURST, 75)
        else
            player:addFame(WINDURST, 8)
        end
    elseif (csid == 752) then
        player:setMissionStatus(player:getNation(), 1)
        player:addKeyItem(xi.ki.STAR_SEEKER)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.STAR_SEEKER)
        player:addTitle(xi.title.FUGITIVE_MINISTER_BOUNTY_HUNTER)

    elseif (csid == 758) then
        finishMissionTimeline(player, 3, csid, option)
    end
end

return entity
