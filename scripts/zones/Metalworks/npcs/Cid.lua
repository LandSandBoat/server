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
require("scripts/globals/quests")
require("scripts/globals/status")
require("scripts/globals/titles")
-----------------------------------
local entity = {}

local function checkThreePaths(player)
    if
        player:getCharVar("COP_Tenzen_s_Path") == 11 and
        player:getCharVar("COP_Ulmia_s_Path") == 8 and
        player:getCharVar("COP_Louverance_s_Path") == 10
    then
        player:completeMission(xi.mission.log_id.COP, xi.mission.id.cop.THREE_PATHS)
        player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.FOR_WHOM_THE_VERSE_IS_SUNG)
        player:setCharVar("PromathiaStatus", 0)
    end
end

entity.onTrade = function(player, npc, trade)
    if (player:getCurrentMission(BASTOK) == xi.mission.id.bastok.THE_CRYSTAL_LINE and player:getMissionStatus(player:getNation()) == 1) then
        if (trade:getItemQty(613, 1) and trade:getItemCount() == 1) then
            player:startEvent(506)
        end
    end
end

entity.onTrigger = function(player, npc)
    local cidsSecret = player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.CID_S_SECRET)
    local bastokMission = player:getCurrentMission(BASTOK)
    local bastokStatus = player:getMissionStatus(player:getNation())
    local copMission = player:getCurrentMission(COP)
    local copStatus = player:getCharVar("PromathiaStatus")
    local ulmiasPath = player:getCharVar("COP_Ulmia_s_Path")
    local tenzensPath = player:getCharVar("COP_Tenzen_s_Path")
    local louverancesPath = player:getCharVar("COP_Louverance_s_Path")
    local hasLetter = player:hasKeyItem(xi.ki.UNFINISHED_LETTER)
    local threePathArg = 0

    -- DAWN
    if
        copMission == xi.mission.id.cop.DAWN and
        copStatus == 3 and
        player:getCharVar("Promathia_kill_day") < os.time() and
        player:getCharVar("COP_tenzen_story") == 0
    then
        player:startEvent(897)

    -- CALM BEFORE THE STORM
    elseif
        copMission == xi.mission.id.cop.CALM_BEFORE_THE_STORM and
        not player:hasKeyItem(xi.ki.LETTERS_FROM_ULMIA_AND_PRISHE) and
        player:getCharVar("COP_Dalham_KILL") == 2 and
        player:getCharVar("COP_Boggelmann_KILL") == 2 and
        player:getCharVar("Cryptonberry_Executor_KILL") == 2
    then
        player:startEvent(892)

    -- FIRE IN THE EYES OF MEN
    elseif
        copMission == xi.mission.id.cop.FIRE_IN_THE_EYES_OF_MEN and
        copStatus == 2 and
        player:getCharVar("Promathia_CID_timer") ~= VanadielDayOfTheYear()
    then
        player:startEvent(890)
    elseif copMission == xi.mission.id.cop.FIRE_IN_THE_EYES_OF_MEN and copStatus == 1 then
        player:startEvent(857)

    -- ONE TO BE FEARED
    elseif copMission == xi.mission.id.cop.ONE_TO_BE_FEARED and copStatus == 0 then
        player:startEvent(856)

    -- THREE PATHS (LOUVERANCE)
    elseif copMission == xi.mission.id.cop.THREE_PATHS and louverancesPath == 6 then
        player:startEvent(852)
    elseif copMission == xi.mission.id.cop.THREE_PATHS and louverancesPath == 9 then
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
    elseif copMission == xi.mission.id.cop.THREE_PATHS and tenzensPath == 10 then
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
    elseif copMission == xi.mission.id.cop.THREE_PATHS and ulmiasPath == 7 then
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
    elseif copMission == xi.mission.id.cop.DESIRES_OF_EMPTINESS and copStatus > 8 then
        player:startEvent(850)

    -- THE ENDURING TUMULT OF WAR
    elseif copMission == xi.mission.id.cop.THE_ENDURING_TUMULT_OF_WAR and copStatus == 1 then
        player:startEvent(849)

    -- THE CALL OF THE WYRMKING
    elseif copMission == xi.mission.id.cop.THE_CALL_OF_THE_WYRMKING and copStatus == 1 then
        player:startEvent(845)

    -- THE ROAD FORKS
    elseif
        copMission == xi.mission.id.cop.THE_ROAD_FORKS and
        player:getCharVar("EMERALD_WATERS_Status") == 7 and
        player:getCharVar("MEMORIES_OF_A_MAIDEN_Status") == 12
    then
        player:startEvent(847)

    -- DARK PUPPET
    elseif
        player:getMainJob() == xi.job.DRK and
        player:getMainLvl() >= AF2_QUEST_LEVEL and
        player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.DARK_LEGACY) == QUEST_COMPLETED and
        player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.DARK_PUPPET) == QUEST_AVAILABLE
    then
        player:startEvent(760)

    -- GEOLOGICAL SURVEY
    elseif bastokMission == xi.mission.id.bastok.GEOLOGICAL_SURVEY then
        if player:hasKeyItem(xi.ki.RED_ACIDITY_TESTER) then
            player:startEvent(504)
        elseif not player:hasKeyItem(xi.ki.BLUE_ACIDITY_TESTER) then
            player:startEvent(503)
        end

    -- THE CRYSTAL LINE
    elseif bastokMission == xi.mission.id.bastok.THE_CRYSTAL_LINE then
        if player:hasKeyItem(xi.ki.C_L_REPORTS) then
            player:showText(npc, ID.text.MISSION_DIALOG_CID_TO_AYAME)
        else
            player:startEvent(505)
        end
    elseif (currentMission == xi.mission.id.bastok.THE_FINAL_IMAGE and player:getMissionStatus(player:getNation()) == 0) then
        player:startEvent(763) -- Bastok Mission 7-1
    elseif (currentMission == xi.mission.id.bastok.THE_FINAL_IMAGE and player:getMissionStatus(player:getNation()) == 2) then
        player:startEvent(764) -- Bastok Mission 7-1 (with Ki)
    --Begin Cid's Secret
    elseif (player:getFameLevel(BASTOK) >= 4 and CidsSecret == QUEST_AVAILABLE) then
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
        npcUtil.giveKeyItem(player, xi.ki.LETTERS_FROM_ULMIA_AND_PRISHE)
    elseif csid == 890 then
        player:setCharVar("PromathiaStatus", 0)
        player:setCharVar("Promathia_CID_timer", 0)
        player:completeMission(xi.mission.log_id.COP, xi.mission.id.cop.FIRE_IN_THE_EYES_OF_MEN)
        player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.CALM_BEFORE_THE_STORM)
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
            player:addTitle(xi.title.TRUE_COMPANION_OF_LOUVERANCE)
        else
            player:addTitle(xi.title.COMPANION_OF_LOUVERANCE)
        end
        checkThreePaths(player)
    elseif csid == 852 then
        player:setCharVar("COP_Louverance_s_Path", 7)
    elseif csid == 850 then
        player:setCharVar("PromathiaStatus", 0)
        player:completeMission(xi.mission.log_id.COP, xi.mission.id.cop.DESIRES_OF_EMPTINESS)
        player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.THREE_PATHS)
    elseif csid == 849 then
        player:setCharVar("PromathiaStatus", 2)
    elseif csid == 856 then
        player:setCharVar("PromathiaStatus", 1)
    elseif csid == 845 then
        player:setCharVar("PromathiaStatus", 0)
        player:completeMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_CALL_OF_THE_WYRMKING)
        player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.A_VESSEL_WITHOUT_A_CAPTAIN)
    elseif csid == 847 then
        -- finishing mission 3.3 and all sub missions
        player:setCharVar("EMERALD_WATERS_Status", 0)
        player:setCharVar("MEMORIES_OF_A_MAIDEN_Status", 0)
        player:completeMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_ROAD_FORKS)
        player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.DESCENDANTS_OF_A_LINE_LOST)
        player:completeMission(xi.mission.log_id.COP, xi.mission.id.cop.DESCENDANTS_OF_A_LINE_LOST)
        player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.COMEDY_OF_ERRORS_ACT_I)
        player:completeMission(xi.mission.log_id.COP, xi.mission.id.cop.COMEDY_OF_ERRORS_ACT_I)
        player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.TENDING_AGED_WOUNDS ) -- starting 3.4 COP mission
    elseif csid == 760 then
        player:addQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.DARK_PUPPET)
        player:setCharVar("darkPuppetCS", 1)
    elseif csid == 503 then
        npcUtil.giveKeyItem(player, xi.ki.BLUE_ACIDITY_TESTER)
    elseif csid == 504 or csid == 764 then
        finishMissionTimeline(player, 1, csid, option)
    elseif (csid == 505 and option == 0) then
        if (player:getMissionStatus(player:getNation()) == 0) then
            if (player:getFreeSlotsCount(0) >= 1) then
                crystal = math.random(4096, 4103)
                player:addItem(crystal)
                player:messageSpecial(ID.text.ITEM_OBTAINED, crystal)
                player:setMissionStatus(player:getNation(), 1)
            else
                player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, crystal)
            end
        end
    elseif (csid == 506 and option == 0) then
        player:tradeComplete()
        player:addKeyItem(xi.ki.C_L_REPORTS)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.C_L_REPORTS)
    elseif (csid == 763) then
        player:setMissionStatus(player:getNation(), 1)
    elseif (csid == 507) then
        player:addQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.CID_S_SECRET)
    elseif (csid == 509) then
        if (player:getFreeSlotsCount(0) >= 1) then
            player:delKeyItem(xi.ki.UNFINISHED_LETTER)
            player:setCharVar("CidsSecret_Event", 0)
            player:addItem(13570)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 13570) -- Ram Mantle
            player:addFame(BASTOK, 30)
            player:completeQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.CID_S_SECRET)
        else
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 13570)
        end
    end
end

return entity
