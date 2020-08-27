-----------------------------------
-- Area: Metalworks
--  NPC: Iron Eater
-- Involved in Missions
-- Starts and Finishes; The Weight of Your Limits
-- !pos 92.936 -19.532 1.814 237
-----------------------------------
require("scripts/globals/missions")
require("scripts/globals/settings")
require("scripts/globals/titles")
require("scripts/globals/wsquest")
local ID = require("scripts/zones/Metalworks/IDs")
-----------------------------------

local wsQuest = tpz.wsquest.steel_cyclone

local TrustMemory = function(player)
    local memories = 0
    --[[ TODO
    -- 2 - The Three Kingdoms
    if player:hasCompletedMission(SANDORIA, tpz.mission.id.sandoria.JOURNEY_TO_BASTOK2) or player:hasCompletedMission(WINDURST, tpz.mission.id.windurst.THE_THREE_KINGDOMS_BASTOK2) then
        memories = memories + 2
    end
    -- 4 - Where Two Paths Converge
    if player:hasCompletedMission(BASTOK, tpz.mission.id.bastok.WHERE_TWO_PATHS_CONVERGE) then
        memories = memories + 4
    end
    -- 8 - The Pirate's Cove
    if player:hasCompletedMission(BASTOK, tpz.mission.id.bastok.THE_PIRATE_S_COVE) then
        memories = memories + 8
    end
    -- 16 - Ayame and Kaede
    if player:hasCompletedQuest(BASTOK, tpz.quest.id.bastok.AYAME_AND_KAEDE) then
        memories = memories + 16
    end
    -- 32 - Light of Judgement
    if player:hasCompletedMission(TOAU, tpz.mission.id.toau.LIGHT_OF_JUDGMENT) then
        memories = memories + 32
    end
    -- 64 - True Strength
    if player:hasCompletedQuest(BASTOK, tpz.quest.id.bastok.TRUE_STRENGTH) then
        memories = memories + 64
    end
    ]]--

    -- Incident with Volker and Zeid
    -- Bring together Mythril Musketeers
    -- Mastery over the way of the axe
    -- Galka grieving over the loss of their homeland
    -- Piece of wood Werei left behind
    -- Help nenew ties with Raogrimm and Deidogg
    -- Chose to become an adventurer in the past
    -- Aht Urhgan, Zazarg
    -- Republican Iron Medal

    return memories
end

function onTrade(player, npc, trade)
    local wsQuestEvent = tpz.wsquest.getTradeEvent(wsQuest, player, trade)

    if wsQuestEvent ~= nil then
        player:startEvent(wsQuestEvent)
    end
end

function onTrigger(player, npc)
    local wsQuestEvent = tpz.wsquest.getTriggerEvent(wsQuest, player)
    local currentMission = player:getCurrentMission(BASTOK)
    local missionStatus = player:getCharVar("MissionStatus")

    if player:hasSpell(897) and player:hasSpell(900) and player:hasSpell(903) and not player:hasSpell(917) then
        player:startEvent(988, 0, 0, 0, TrustMemory(player))
    elseif wsQuestEvent ~= nil then
        player:startEvent(wsQuestEvent)
    elseif (currentMission == tpz.mission.id.bastok.THE_FOUR_MUSKETEERS and missionStatus == 0) then -- Four Musketeers
        player:startEvent(715)
    elseif (currentMission == tpz.mission.id.bastok.WHERE_TWO_PATHS_CONVERGE and player:getCharVar("MissionStatus") == 0) then
        player:startEvent(780)
    elseif (currentMission == tpz.mission.id.bastok.WHERE_TWO_PATHS_CONVERGE and player:getCharVar("MissionStatus") == 2) then
        player:startEvent(782)
    elseif (player:getCharVar("Flagbastok") == 1) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 182)
        else
            player:setCharVar("Flagbastok", 0)
            player:addItem(182)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 182)
        end
    elseif (currentMission == tpz.mission.id.bastok.THE_FOUR_MUSKETEERS and missionStatus == 1) then
        player:startEvent(716)
    elseif (currentMission == tpz.mission.id.bastok.THE_CHAINS_THAT_BIND_US and missionStatus == 0) then
        player:startEvent(767) -- First cutscene of mission
    elseif (currentMission == tpz.mission.id.bastok.THE_CHAINS_THAT_BIND_US) and (missionStatus == 2) then
        player:showText(npc, 8596) -- Dialogue after first cutscene
    elseif (currentMission == tpz.mission.id.bastok.THE_CHAINS_THAT_BIND_US) and (missionStatus == 3) then
        player:startEvent(768) -- Cutscene on return from Quicksand Caves
    elseif (player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.FIRES_OF_DISCONTENT) == QUEST_ACCEPTED) then
        if (player:getCharVar("FiresOfDiscProg") == 1) then
            player:startEvent(956)
        else
            player:startEvent(957)
        end
    else
        player:startEvent(604)
    end
end

function onEventFinish(player, csid, option)
    if (csid == 715 and option == 0) then
        player:setCharVar("MissionStatus", 1)
    elseif (csid == 780) then
        player:setCharVar("MissionStatus", 1)
    elseif (csid == 767 and option == 0) then
        player:setCharVar("MissionStatus", 1)
    elseif (csid == 768) then
        finishMissionTimeline(player, 1, csid, option)
    elseif (csid == 782) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 182)
            player:setCharVar("Flagbastok", 1)
        else
            player:addItem(182)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 182)
        end
        player:setCharVar("MissionStatus", 0)
        player:completeMission(BASTOK, tpz.mission.id.bastok.WHERE_TWO_PATHS_CONVERGE)
        player:setRank(10)
        player:addGil(GIL_RATE * 100000)
        player:messageSpecial(ID.text.GIL_OBTAINED, GIL_RATE * 100000)
        player:setTitle(tpz.title.HERO_AMONG_HEROES)
    elseif (csid == 956) then
        player:setCharVar("FiresOfDiscProg", 2)
    elseif csid == 988 then
        player:addSpell(917, true, true)
        player:messageSpecial(ID.text.YOU_LEARNED_TRUST, 0, 917)
    else
        tpz.wsquest.handleEventFinish(wsQuest, player, csid, option, ID.text.STEEL_CYCLONE_LEARNED)
    end
end
