-----------------------------------
-- Area: Windurst Waters
--  NPC: Moreno-Toeno
-- Starts and Finishes Quest: Teacher's Pet
-- !pos
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
    elseif (player:getCurrentMission(WINDURST) == xi.mission.id.windurst.A_TESTING_TIME) then
        local missionStatus = player:getMissionStatus(player:getNation())
        local alreadyCompleted = player:hasCompletedMission(xi.mission.log_id.WINDURST, xi.mission.id.windurst.A_TESTING_TIME)
        if (missionStatus == 0) then
            if (alreadyCompleted == false) then
                player:startEvent(182) -- First start at tahrongi
            else
                player:startEvent(687) -- Repeat at buburimu
            end
        elseif (missionStatus == 1) then
            start_time = player:getCharVar("testingTime_start_time")
            seconds_passed = os.time() - start_time

            -- one Vana'diel Day is 3456 seconds (2 day for repeat)
            if ((alreadyCompleted == false and seconds_passed > 3456) or (alreadyCompleted and seconds_passed > 6912)) then
                player:startEvent(202)
            -- are we in the last game hour of the Vana'diel Day?
            elseif (alreadyCompleted == false and seconds_passed >= 3312) then
                killcount = player:getCharVar("testingTime_crea_count")
                if (killcount >= 35) then
                    event = 201
                elseif (killcount >= 30) then
                    event = 200
                elseif (killcount >= 19) then
                    event = 199
                else
                    event = 198
                end
                player:startEvent(event, 0, VanadielHour(), 1, killcount)
            -- are we in the last game hour of the Vana'diel Day? REPEAT
            elseif (alreadyCompleted and seconds_passed >= 6768) then
                killcount = player:getCharVar("testingTime_crea_count")
                if (killcount >= 35) then
                    event = 206
                elseif (killcount >= 30) then
                    event = 209
                else
                    event = 208
                end
                player:startEvent(event, 0, VanadielHour(), 1, killcount)
            else
                start_day = player:getCharVar("testingTime_start_day")
                start_hour = player:getCharVar("testingTime_start_hour")
                if (VanadielDayOfTheYear() == start_day) then
                    hours_passed = VanadielHour() - start_hour
                elseif (VanadielDayOfTheYear() == start_day + 1) then
                    hours_passed = VanadielHour() - start_hour + 24
                else
                    if (alreadyCompleted) then hours_passed = (24 - start_hour) + VanadielHour() + 24
                    else hours_passed = (24 - start_hour) + VanadielHour(); end
                end
                if (alreadyCompleted) then
                    player:startEvent(204, 0, 0, 0, 0, 0, VanadielHour(), 48 - hours_passed, 0)
                else
                    player:startEvent(183, 0, VanadielHour(), 24 - hours_passed)
                end

            end
        end
    elseif (teacherstatus == QUEST_AVAILABLE) then
        prog = player:getCharVar("QuestTeachersPet_prog")
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
        rand = math.random(1, 2)
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
        player:addGil(GIL_RATE*250)
        player:setCharVar("QuestTeachersPet_prog", 0)
        player:tradeComplete(trade)
        if (player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.TEACHER_S_PET) == QUEST_ACCEPTED) then
            player:completeQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.TEACHER_S_PET)
            player:addFame(WINDURST, 75)
        else
            player:addFame(WINDURST, 8)
        end
    elseif (csid == 182 or csid == 687) and option ~= 1 then -- start
        player:addKeyItem(xi.ki.CREATURE_COUNTER_MAGIC_DOLL)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.CREATURE_COUNTER_MAGIC_DOLL)
        player:setMissionStatus(player:getNation(), 1)
        player:setCharVar("testingTime_start_day", VanadielDayOfTheYear())
        player:setCharVar("testingTime_start_hour", VanadielHour())
        player:setCharVar("testingTime_start_time", os.time())
    elseif (csid == 198 or csid == 199 or csid == 202 or csid == 208) then -- failed testing time
        player:delKeyItem(xi.ki.CREATURE_COUNTER_MAGIC_DOLL)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED + 1, xi.ki.CREATURE_COUNTER_MAGIC_DOLL)
        player:setMissionStatus(player:getNation(), 0)
        player:setCharVar("testingTime_crea_count", 0)
        player:setCharVar("testingTime_start_day", 0)
        player:setCharVar("testingTime_start_hour", 0)
        player:setCharVar("testingTime_start_time", 0)
        player:delMission(xi.mission.log_id.WINDURST, xi.mission.id.windurst.A_TESTING_TIME)
    elseif (csid == 200 or csid == 201) then -- first time win
        finishMissionTimeline(player, 1, csid, option)

        player:setCharVar("testingTime_crea_count", 0)
        player:setCharVar("testingTime_start_day", 0)
        player:setCharVar("testingTime_start_hour", 0)
        player:setCharVar("testingTime_start_time", 0)
    elseif (csid == 209 or csid == 206) then -- succesfull repeat attempt (Buburimu).
        finishMissionTimeline(player, 1, csid, option)

        player:setCharVar("testingTime_crea_count", 0)
        player:setCharVar("testingTime_start_day", 0)
        player:setCharVar("testingTime_start_hour", 0)
        player:setCharVar("testingTime_start_time", 0)
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
