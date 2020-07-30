-----------------------------------
-- Area: West Ronfaure
-- NPC: Vilatroire
-- Involved in Quests: "Introduction To Teamwork", "Intermediate Teamwork",
-- "Advanced Teamwork"
-- !pos -260.361 -70.999 423.420 100
-----------------------------------
local ID = require("scripts/zones/West_Ronfaure/IDs")
require("scripts/globals/quests")
require("scripts/globals/titles")
require("scripts/globals/status")
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local sandyFame = player:getFameLevel(SANDORIA)

    local questIntroToTeamwork = player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.INTRODUCTION_TO_TEAMWORK)
    local questIntermediateTeamwork = player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.INTERMEDIATE_TEAMWORK)
    local questAdvancedTeamwork = player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.ADVANCED_TEAMWORK)

    if questIntroToTeamwork == QUEST_AVAILABLE and sandyFame >= 2 then
         player:startEvent(135) -- Starts first quest - 6 members same alliance
    elseif questIntroToTeamwork == QUEST_AVAILABLE and sandyFame < 2 then
        player:startEvent(134) -- You don't have the requirements to start the first quest
    elseif questIntroToTeamwork == QUEST_ACCEPTED then
        player:startEvent(129, 0, 1) -- starts the ready check for all three quests
    elseif questIntroToTeamwork == QUEST_COMPLETED and questIntermediateTeamwork == QUEST_AVAILABLE and sandyFame >= 3 and player:getMainLvl() >= 10 then
        player:startEvent(133) -- Same race
    elseif questIntroToTeamwork == QUEST_COMPLETED and questIntermediateTeamwork == QUEST_AVAILABLE and sandyFame < 3 and player:getMainLvl() < 10 then
        player:startEvent(132) -- You don't have the requirements to start the second quest
    elseif questIntermediateTeamwork == QUEST_ACCEPTED then
        player:startEvent(129, 0, 2) -- starts the ready check for all three quests
    elseif questIntermediateTeamwork == QUEST_COMPLETED and questAdvancedTeamwork == QUEST_AVAILABLE and sandyFame >= 4 and player:getMainLvl() >= 10 then
        player:startEvent(131) -- Same job
    elseif questIntermediateTeamwork == QUEST_COMPLETED and questAdvancedTeamwork == QUEST_AVAILABLE and sandyFame < 4 and player:getMainLvl() < 10 then
        player:startEvent(130) -- post second and third quest dialog
    elseif questAdvancedTeamwork == QUEST_ACCEPTED then
        player:startEvent(129, 0, 3) -- starts the ready check for all three quests
    elseif questAdvancedTeamwork == QUEST_COMPLETED then
        player:startEvent(130) -- post second and third quest dialog
    else
        player:startEvent(136) -- Default before quests
    end
end

function onEventUpdate(player, csid, option)
    -- csid 129 happens for both quests
    if csid == 129 then
        local questIntroToTeamwork = player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.INTRODUCTION_TO_TEAMWORK)
        local questIntermediateTeamwork = player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.INTERMEDIATE_TEAMWORK)
        local questAdvancedTeamwork = player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.ADVANCED_TEAMWORK)

        -- newer versions of these quests only require a party of 2.
        -- older versions require all 6
        local partySizeRequirement = 2

        local party = player:getParty()
        local pRace = player:getRace()

        local partySameNationCount = 0
        local partySameRaceCount = 0
        local partySameJobCount = 0

        if #party >= partySizeRequirement then

            for key, member in pairs(party) do
                local mRace = member:getRace()

                if member:getZoneID() ~= player:getZoneID() or member:checkDistance(player) > 15 then
                    player:updateEvent(1) -- member not in zone or range
                    return
                else
                    if member:getNation() == player:getNation() then
                        partySameNationCount = partySameNationCount + 1
                    end

                    if (pRace == tpz.race.HUME_M or pRace == tpz.race.HUME_F) and (mRace == tpz.race.HUME_M or mRace == tpz.race.HUME_F) then
                        partySameRaceCount = partySameRaceCount + 1
                    elseif (pRace == tpz.race.ELVAAN_M or pRace == tpz.race.ELVAAN_F) and (mRace == tpz.race.ELVAAN_M or mRace == tpz.race.ELVAAN_F) then
                        partySameRaceCount = partySameRaceCount + 1
                    elseif (pRace == tpz.race.TARU_M or pRace == tpz.race.TARU_F) and (mRace == tpz.race.TARU_M or mRace == tpz.race.TARU_F) then
                        partySameRaceCount = partySameRaceCount + 1
                    elseif pRace == tpz.race.GALKA and mRace == tpz.race.GALKA then
                        partySameRaceCount = partySameRaceCount + 1
                    elseif pRace == tpz.race.MITHRA and mRace == tpz.race.MITHRA then
                        partySameRaceCount = partySameRaceCount + 1
                    end

                    if member:getMainJob() == player:getMainJob() then
                        partySameJobCount = partySameJobCount + 1
                    end
                end
            end

            if questIntroToTeamwork == QUEST_ACCEPTED then
                if partySameNationCount == partySizeRequirement then
                    player:setLocalVar("introToTmwrk_pass", 1) -- nation requirements met
                    player:updateEvent(15, 1)
                else
                    player:updateEvent(3) -- not the same nation
                end
            elseif questIntermediateTeamwork == QUEST_ACCEPTED then
                if partySameRaceCount == partySizeRequirement then
                    player:setLocalVar("intermedTmwrk_pass", 1)
                    player:updateEvent(15, 2) -- race requirements met
                else
                    
                    player:updateEvent(4) -- not the same race
                end
            elseif questAdvancedTeamwork == QUEST_ACCEPTED then
                if partySameJobCount == partySizeRequirement then
                    player:setLocalVar("advTmwrk_pass", 1)
                    player:updateEvent(15, 3) -- job requirements met
                else
                    player:updateEvent(5) -- not the same job
                end
            end
        else
            player:updateEvent(1) -- need more party members
        end
    end
end

function onEventFinish(player, csid, option)
    -- csid 129 is the event for when they have selected ready/not ready option is always 0
    if csid == 129 and option == 0 then
        local questIntroToTeamwork = player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.INTRODUCTION_TO_TEAMWORK)
        local questIntermediateTeamwork = player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.INTERMEDIATE_TEAMWORK)
        local questAdvancedTeamwork = player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.ADVANCED_TEAMWORK)

        if questIntroToTeamwork == QUEST_ACCEPTED and player:getLocalVar("introToTmwrk_pass") == 1 then
            npcUtil.completeQuest(player, SANDORIA, tpz.quest.id.sandoria.INTRODUCTION_TO_TEAMWORK, {
                item = 13442,
                fame = 80, -- fame defaults to 30 if not set
                title = tpz.title.THIRDRATE_ORGANIZER,
            })
        elseif questIntermediateTeamwork == QUEST_ACCEPTED and player:getLocalVar("intermedTmwrk_pass") == 1 then
            npcUtil.completeQuest(player, SANDORIA, tpz.quest.id.sandoria.INTERMEDIATE_TEAMWORK, {
                item = 4994,
                fame = 80, -- fame defaults to 30 if not set
                title = tpz.title.SECONDRATE_ORGANIZER,
            })
        elseif questAdvancedTeamwork == QUEST_ACCEPTED and player:getLocalVar("advTmwrk_pass") == 1 then
            npcUtil.completeQuest(player, SANDORIA, tpz.quest.id.sandoria.ADVANCED_TEAMWORK, {
                item = 13459,
                fame = 80, -- fame defaults to 30 if not set
                title = tpz.title.FIRSTRATE_ORGANIZER,
            })
        end
    elseif csid == 131 and option == 1 then
        -- 131 is the third and last quest
        player:addQuest(SANDORIA, tpz.quest.id.sandoria.ADVANCED_TEAMWORK)
    elseif csid == 133 and option == 1 then
        -- 133 is the second quest
        player:addQuest(SANDORIA, tpz.quest.id.sandoria.INTERMEDIATE_TEAMWORK)
    elseif csid == 135 and option == 1 then
        -- 135 is the first quest
        player:addQuest(SANDORIA, tpz.quest.id.sandoria.INTRODUCTION_TO_TEAMWORK)
    end
end