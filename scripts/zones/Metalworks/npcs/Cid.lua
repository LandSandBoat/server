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
end

entity.onTrigger = function(player, npc)
    local cidsSecret = player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.CID_S_SECRET)
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

    -- DARK PUPPET
    elseif
        player:getMainJob() == xi.job.DRK and
        player:getMainLvl() >= xi.settings.AF2_QUEST_LEVEL and
        player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.DARK_LEGACY) == QUEST_COMPLETED and
        player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.DARK_PUPPET) == QUEST_AVAILABLE
    then
        player:startEvent(760)

    --Begin Cid's Secret
    elseif (player:getFameLevel(BASTOK) >= 4 and cidsSecret == QUEST_AVAILABLE) then
        player:startEvent(507)
    elseif cidsSecret == QUEST_ACCEPTED and not hasLetter and player:getCharVar("CidsSecret_Event") == 1 then
        player:startEvent(508) -- After talking to Hilda, Cid gives information on the item she needs
    elseif cidsSecret == QUEST_ACCEPTED and not hasLetter then
        player:startEvent(502) -- Reminder dialogue from Cid if you have not spoken to Hilda
    elseif cidsSecret == QUEST_ACCEPTED and hasLetter then
        player:startEvent(509)
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
    elseif csid == 856 then
        player:setCharVar("PromathiaStatus", 1)
    elseif csid == 760 then
        player:addQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.DARK_PUPPET)
        player:setCharVar("darkPuppetCS", 1)
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
