-----------------------------------
-- Area: Metalworks
--  NPC: Cid
-- Starts & Finishes Quest: Cid's Secret, The Usual, Dark Puppet (start), Shoot First, Ask Questions Later
-- Involved in Mission: Bastok 7-1
-- !pos -12 -12 1 237
-----------------------------------
local ID = require("scripts/zones/Metalworks/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/npc_util")
require("scripts/globals/wsquest")
require("scripts/globals/quests")
require("scripts/globals/status")
require("scripts/globals/titles")
-----------------------------------
local entity = {}

local wsQuest = tpz.wsquest.detonator

local function checkThreePaths(player)
    if
        player:getCharVar("COP_Tenzen_s_Path") == 11 and
        player:getCharVar("COP_Ulmia_s_Path") == 8 and
        player:getCharVar("COP_Louverance_s_Path") == 10
    then
        player:completeMission(tpz.mission.log_id.COP, tpz.mission.id.cop.THREE_PATHS)
        player:addMission(tpz.mission.log_id.COP, tpz.mission.id.cop.FOR_WHOM_THE_VERSE_IS_SUNG)
        player:setCharVar("PromathiaStatus", 0)
    end
end

entity.onTrade = function(player, npc, trade)
    local wsQuestEvent = tpz.wsquest.getTradeEvent(wsQuest, player, trade)

    if wsQuestEvent ~= nil then
        player:startEvent(wsQuestEvent)
    elseif
        player:getCurrentMission(BASTOK) == tpz.mission.id.bastok.THE_CRYSTAL_LINE and
        player:getCharVar("MissionStatus") == 1 and
        npcUtil.tradeHas(trade, 613)
    then
        player:startEvent(506)
    end
end

entity.onTrigger = function(player, npc)
    local wsQuestEvent = tpz.wsquest.getTriggerEvent(wsQuest, player)
    local cidsSecret = player:getQuestStatus(tpz.quest.log_id.BASTOK, tpz.quest.id.bastok.CID_S_SECRET)
    local bastokMission = player:getCurrentMission(BASTOK)
    local bastokStatus = player:getCharVar("MissionStatus")
    local copMission = player:getCurrentMission(COP)
    local copStatus = player:getCharVar("PromathiaStatus")
    local ulmiasPath = player:getCharVar("COP_Ulmia_s_Path")
    local tenzensPath = player:getCharVar("COP_Tenzen_s_Path")
    local louverancesPath = player:getCharVar("COP_Louverance_s_Path")
    local hasLetter = player:hasKeyItem(tpz.ki.UNFINISHED_LETTER)
    local threePathArg = 0

    -- SHOOT FIRST, ASK QUESTIONS LATER
    if wsQuestEvent ~= nil then
        player:startEvent(wsQuestEvent)

    -- DAWN
    elseif
        copMission == tpz.mission.id.cop.DAWN and
        copStatus == 3 and
        player:getCharVar("Promathia_kill_day") < os.time() and
        player:getCharVar("COP_tenzen_story") == 0
    then
        player:startEvent(897)

    -- CALM BEFORE THE STORM
    elseif
        copMission == tpz.mission.id.cop.CALM_BEFORE_THE_STORM and
        not player:hasKeyItem(tpz.ki.LETTERS_FROM_ULMIA_AND_PRISHE) and
        player:getCharVar("COP_Dalham_KILL") == 2 and
        player:getCharVar("COP_Boggelmann_KILL") == 2 and
        player:getCharVar("Cryptonberry_Executor_KILL") == 2
    then
        player:startEvent(892)

    -- FIRE IN THE EYES OF MEN
    elseif
        copMission == tpz.mission.id.cop.FIRE_IN_THE_EYES_OF_MEN and
        copStatus == 2 and
        player:getCharVar("Promathia_CID_timer") ~= VanadielDayOfTheYear()
    then
        player:startEvent(890)
    elseif copMission == tpz.mission.id.cop.FIRE_IN_THE_EYES_OF_MEN and copStatus == 1 then
        player:startEvent(857)

    -- ONE TO BE FEARED
    elseif copMission == tpz.mission.id.cop.ONE_TO_BE_FEARED and copStatus == 0 then
        player:startEvent(856)

    -- THREE PATHS (LOUVERANCE)
    elseif copMission == tpz.mission.id.cop.THREE_PATHS and louverancesPath == 6 then
        player:startEvent(852)
    elseif copMission == tpz.mission.id.cop.THREE_PATHS and louverancesPath == 9 then
        if tenzensPath == 11 and ulmiasPath == 8 then
            threePathArg = 6
        elseif tenzensPath == 11 then
            threePathArg = 2
        elseif ulmiasPath == 8 then
            threePathArg = 4
        else
            threePathArg = 1
        end

        player:startEvent(853, threePathArg)

    -- THREE PATHS (TENZEN)
    elseif copMission == tpz.mission.id.cop.THREE_PATHS and tenzensPath == 10 then
        if ulmiasPath == 8 and louverancesPath == 10 then
            threePathArg = 5
        elseif louverancesPath == 10 then
            threePathArg = 3
        elseif ulmiasPath == 8 then
            threePathArg = 4
        else
            threePathArg = 1
        end

        player:startEvent(854, threePathArg)

    -- THREE PATHS (ULMIA)
    elseif copMission == tpz.mission.id.cop.THREE_PATHS and ulmiasPath == 7 then
        if tenzensPath == 11 and louverancesPath == 10 then
            threePathArg = 3
        elseif louverancesPath == 10 then
            threePathArg = 1
        elseif tenzensPath == 11 then
            threePathArg = 2
        else
            threePathArg = 0
        end

        player:startEvent(855, threePathArg)

    -- DESIRES OF EMPTINESS
    elseif copMission == tpz.mission.id.cop.DESIRES_OF_EMPTINESS and copStatus > 8 then
        player:startEvent(850)

    -- THE ENDURING TUMULT OF WAR
    elseif copMission == tpz.mission.id.cop.THE_ENDURING_TUMULT_OF_WAR and copStatus == 1 then
        player:startEvent(849)

    -- THE CALL OF THE WYRMKING
    elseif copMission == tpz.mission.id.cop.THE_CALL_OF_THE_WYRMKING and copStatus == 1 then
        player:startEvent(845)

    -- THE ROAD FORKS
    elseif
        copMission == tpz.mission.id.cop.THE_ROAD_FORKS and
        player:getCharVar("EMERALD_WATERS_Status") == 7 and
        player:getCharVar("MEMORIES_OF_A_MAIDEN_Status") == 12
    then
        player:startEvent(847)

    -- DARK PUPPET
    elseif
        player:getMainJob() == tpz.job.DRK and
        player:getMainLvl() >= AF2_QUEST_LEVEL and
        player:getQuestStatus(tpz.quest.log_id.BASTOK, tpz.quest.id.bastok.DARK_LEGACY) == QUEST_COMPLETED and
        player:getQuestStatus(tpz.quest.log_id.BASTOK, tpz.quest.id.bastok.DARK_PUPPET) == QUEST_AVAILABLE
    then
        player:startEvent(760)

    -- GEOLOGICAL SURVEY
    elseif bastokMission == tpz.mission.id.bastok.GEOLOGICAL_SURVEY then
        if player:hasKeyItem(tpz.ki.RED_ACIDITY_TESTER) then
            player:startEvent(504)
        elseif not player:hasKeyItem(tpz.ki.BLUE_ACIDITY_TESTER) then
            player:startEvent(503)
        end

    -- THE CRYSTAL LINE
    elseif bastokMission == tpz.mission.id.bastok.THE_CRYSTAL_LINE then
        if player:hasKeyItem(tpz.ki.C_L_REPORTS) then
            player:showText(npc, ID.text.MISSION_DIALOG_CID_TO_AYAME)
        else
            player:startEvent(505)
        end

    -- THE FINAL IMAGE
    elseif bastokMission == tpz.mission.id.bastok.THE_FINAL_IMAGE and bastokStatus == 0 then
        player:startEvent(763)
    elseif bastokMission == tpz.mission.id.bastok.THE_FINAL_IMAGE and bastokStatus == 2 then
        player:startEvent(764)

    -- CID'S SECRET
    elseif player:getFameLevel(BASTOK) >= 4 and cidsSecret == QUEST_AVAILABLE then
        player:startEvent(507)
    elseif cidsSecret == QUEST_ACCEPTED and not hasLetter and player:getCharVar("CidsSecret_Event") == 1 then
        player:startEvent(508) -- After talking to Hilda, Cid gives information on the item she needs
    elseif cidsSecret == QUEST_ACCEPTED and not hasLetter then
        player:startEvent(502) -- Reminder dialogue from Cid if you have not spoken to Hilda
    elseif cidsSecret == QUEST_ACCEPTED and hasLetter then
        player:startEvent(509)

    -- DEFAULT DIALOG
    else
        player:startEvent(500)
    end
end

entity.onEventFinish = function(player, csid, option)
    if csid == 897 then
        player:setCharVar("COP_tenzen_story", 1)
    elseif csid == 892 then
        npcUtil.giveKeyItem(player, tpz.ki.LETTERS_FROM_ULMIA_AND_PRISHE)
    elseif csid == 890 then
        player:setCharVar("PromathiaStatus", 0)
        player:setCharVar("Promathia_CID_timer", 0)
        player:completeMission(tpz.mission.log_id.COP, tpz.mission.id.cop.FIRE_IN_THE_EYES_OF_MEN)
        player:addMission(tpz.mission.log_id.COP, tpz.mission.id.cop.CALM_BEFORE_THE_STORM)
    elseif csid == 857 then
        player:setCharVar("PromathiaStatus", 2)
        player:setCharVar("Promathia_CID_timer", VanadielDayOfTheYear())
    elseif csid == 855 then
        player:setCharVar("COP_Ulmia_s_Path", 8)
        checkThreePaths(player)
    elseif csid == 854 then
        player:setCharVar("COP_Tenzen_s_Path", 11)
        checkThreePaths(player)
    elseif csid == 853 then
        player:setCharVar("COP_Louverance_s_Path", 10)
        if player:getCharVar("COP_Tenzen_s_Path") == 11 and player:getCharVar("COP_Ulmia_s_Path") == 8 then
            player:addTitle(tpz.title.TRUE_COMPANION_OF_LOUVERANCE)
        else
            player:addTitle(tpz.title.COMPANION_OF_LOUVERANCE)
        end
        checkThreePaths(player)
    elseif csid == 852 then
        player:setCharVar("COP_Louverance_s_Path", 7)
    elseif csid == 850 then
        player:setCharVar("PromathiaStatus", 0)
        player:completeMission(tpz.mission.log_id.COP, tpz.mission.id.cop.DESIRES_OF_EMPTINESS)
        player:addMission(tpz.mission.log_id.COP, tpz.mission.id.cop.THREE_PATHS)
    elseif csid == 849 then
        player:setCharVar("PromathiaStatus", 2)
    elseif csid == 856 then
        player:setCharVar("PromathiaStatus", 1)
    elseif csid == 845 then
        player:setCharVar("PromathiaStatus", 0)
        player:completeMission(tpz.mission.log_id.COP, tpz.mission.id.cop.THE_CALL_OF_THE_WYRMKING)
        player:addMission(tpz.mission.log_id.COP, tpz.mission.id.cop.A_VESSEL_WITHOUT_A_CAPTAIN)
    elseif csid == 847 then
        -- finishing mission 3.3 and all sub missions
        player:setCharVar("EMERALD_WATERS_Status", 0)
        player:setCharVar("MEMORIES_OF_A_MAIDEN_Status", 0)
        player:completeMission(tpz.mission.log_id.COP, tpz.mission.id.cop.THE_ROAD_FORKS)
        player:addMission(tpz.mission.log_id.COP, tpz.mission.id.cop.DESCENDANTS_OF_A_LINE_LOST)
        player:completeMission(tpz.mission.log_id.COP, tpz.mission.id.cop.DESCENDANTS_OF_A_LINE_LOST)
        player:addMission(tpz.mission.log_id.COP, tpz.mission.id.cop.COMEDY_OF_ERRORS_ACT_I)
        player:completeMission(tpz.mission.log_id.COP, tpz.mission.id.cop.COMEDY_OF_ERRORS_ACT_I)
        player:addMission(tpz.mission.log_id.COP, tpz.mission.id.cop.TENDING_AGED_WOUNDS ) -- starting 3.4 COP mission
    elseif csid == 760 then
        player:addQuest(tpz.quest.log_id.BASTOK, tpz.quest.id.bastok.DARK_PUPPET)
        player:setCharVar("darkPuppetCS", 1)
    elseif csid == 503 then
        npcUtil.giveKeyItem(player, tpz.ki.BLUE_ACIDITY_TESTER)
    elseif csid == 504 or csid == 764 then
        finishMissionTimeline(player, 1, csid, option)
    elseif csid == 505 and option == 0 then
        if player:getCharVar("MissionStatus") == 0 then
            local crystal = math.random(4096, 4103)

            if npcUtil.giveItem(player, crystal) then
                player:setCharVar("MissionStatus", 1)
            end
        end
    elseif csid == 506 and option == 0 then
        npcUtil.giveKeyItem(player, tpz.ki.C_L_REPORTS)
        player:confirmTrade()
    elseif csid == 763 then
        player:setCharVar("MissionStatus", 1)
    elseif csid == 507 then
        player:addQuest(tpz.quest.log_id.BASTOK, tpz.quest.id.bastok.CID_S_SECRET)
    elseif
        csid == 509 and
        npcUtil.completeQuest(player, BASTOK, tpz.quest.id.bastok.CID_S_SECRET, {
            item = 13570,
            var = "CidsSecret_Event",
        })
    then
        player:delKeyItem(tpz.ki.UNFINISHED_LETTER)
    else
        tpz.wsquest.handleEventFinish(wsQuest, player, csid, option, ID.text.DETONATOR_LEARNED)
    end
end

return entity
