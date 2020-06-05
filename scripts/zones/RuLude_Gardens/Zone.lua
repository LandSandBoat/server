-----------------------------------
--
-- Zone: RuLude_Gardens (243)
--
-----------------------------------
local ID = require("scripts/zones/RuLude_Gardens/IDs")
require("scripts/globals/conquest")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/npc_util")
require("scripts/globals/common")
require("scripts/globals/quests")
-----------------------------------

function onInitialize(zone)
    zone:registerRegion(1, -4, -2, 40, 4, 3, 50)
end

function onZoneIn(player, prevZone)
    local cs = -1

    if player:getCurrentMission(COP) == tpz.mission.id.cop.FOR_WHOM_THE_VERSE_IS_SUNG  and  player:getCharVar("PromathiaStatus") == 2 then
        cs = 10047
    end

    -- MOG HOUSE EXIT
    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        position = math.random(1, 5) + 45
        player:setPos(position, 10, -73, 192)
    end

    return cs
end

function onConquestUpdate(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

function onRegionEnter(player, region)

    local regionID = region:GetRegionID()
    -- printf("regionID: %u", regionID)

    if regionID == 1 then
        if player:getCurrentMission(COP) == tpz.mission.id.cop.A_VESSEL_WITHOUT_A_CAPTAIN and player:getCharVar("PromathiaStatus") == 1 then
            player:startEvent(65, player:getNation())
        elseif player:getCurrentMission(COP) == tpz.mission.id.cop.A_PLACE_TO_RETURN and player:getCharVar("PromathiaStatus") == 0 then
            player:startEvent(10048)
        elseif player:getCurrentMission(COP) == tpz.mission.id.cop.FLAMES_IN_THE_DARKNESS and player:getCharVar("PromathiaStatus") == 2 then
            player:startEvent(10051)
        elseif player:getCurrentMission(TOAU) == tpz.mission.id.toau.EASTERLY_WINDS and player:getCharVar("AhtUrganStatus") == 1 then
            player:startEvent(10094)
        elseif player:getCurrentMission(TOAU) == tpz.mission.id.toau.ALLIED_RUMBLINGS then
            player:startEvent(10097)
        elseif player:getCurrentMission(COP) == tpz.mission.id.cop.DAWN then
            if
                player:getCharVar("COP_3-taru_story") == 2 and
                player:getCharVar("COP_shikarees_story") == 1 and
                player:getCharVar("COP_louverance_story") == 3 and
                player:getCharVar("COP_tenzen_story") == 1 and
                player:getCharVar("COP_jabbos_story") == 1
            then
                player:startEvent(122)
            elseif player:getCharVar("PromathiaStatus") == 7 then
                if player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.STORMS_OF_FATE) == QUEST_AVAILABLE then
                    player:startEvent(142)
                elseif player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.STORMS_OF_FATE) == QUEST_ACCEPTED and player:getCharVar('StormsOfFate') == 3 then
                    player:startEvent(143)
                elseif
                    player:hasCompletedQuest(JEUNO, tpz.quest.id.jeuno.STORMS_OF_FATE) and
                    player:getCurrentMission(ZILART) == tpz.mission.id.zilart.AWAKENING and
                    player:getCharVar("ZilartStatus") == 3 and
                    player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.SHADOWS_OF_THE_DEPARTED) == QUEST_AVAILABLE and
                    player:getCharVar("StormsOfFateWait") <= os.time()
                then
                    player:startEvent(161)
                elseif
                    player:hasKeyItem(tpz.ki.PROMYVION_HOLLA_SLIVER) and
                    player:hasKeyItem(tpz.ki.PROMYVION_MEA_SLIVER) and
                    player:hasKeyItem(tpz.ki.PROMYVION_DEM_SLIVER)
                then
                    player:startEvent(162)
                elseif
                    player:hasCompletedQuest(JEUNO, tpz.quest.id.jeuno.SHADOWS_OF_THE_DEPARTED) and
                    player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.APOCALYPSE_NIGH) == QUEST_AVAILABLE and
                    player:getLocalVar('ANZONE') == 0 and
                    player:getCharVar("ApocNighWait") <= os.time()
                then
                    player:startEvent(123)
                end
            end
        end
    end
end

function onRegionLeave(player, region)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 65 then
        player:setCharVar("PromathiaStatus", 0)
        player:completeMission(COP, tpz.mission.id.cop.A_VESSEL_WITHOUT_A_CAPTAIN)
        player:addMission(COP, tpz.mission.id.cop.THE_ROAD_FORKS) -- THE_ROAD_FORKS -- global mission 3.3
        -- We can't have more than 1 current mission at the time, so we keep The road forks as current mission
        -- progress are recorded in the following two variables
        player:setCharVar("MEMORIES_OF_A_MAIDEN_Status", 1) -- MEMORIES_OF_A_MAIDEN--3-3B: Windurst Road
        player:setCharVar("EMERALD_WATERS_Status", 1) -- EMERALD_WATERS-- 3-3A: San d'Oria Road
    elseif csid == 10047 then
        player:setCharVar("PromathiaStatus", 0)
        player:completeMission(COP, tpz.mission.id.cop.FOR_WHOM_THE_VERSE_IS_SUNG)
        player:addMission(COP, tpz.mission.id.cop.A_PLACE_TO_RETURN)
    elseif csid == 10048 then
        player:setCharVar("PromathiaStatus", 1)
    elseif csid == 10051 then
        player:setCharVar("PromathiaStatus", 3)
    elseif csid == 122 then
        player:setCharVar("PromathiaStatus", 4)
        player:setCharVar("COP_3-taru_story", 0)
        player:setCharVar("COP_shikarees_story", 0)
        player:setCharVar("COP_louverance_story", 0)
        player:setCharVar("COP_tenzen_story", 0)
        player:setCharVar("COP_jabbos_story", 0)
    elseif csid == 10094 then
        if option == 1 then
            if player:getFreeSlotsCount() == 0 then
                player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 2184)
            else
                player:completeMission(TOAU, tpz.mission.id.toau.EASTERLY_WINDS)
                player:addMission(TOAU, tpz.mission.id.toau.WESTERLY_WINDS)
                player:setCharVar("AhtUrganStatus", 0)
                player:addItem(2184, 10)
                player:messageSpecial(ID.text.ITEM_OBTAINED, 2184)
            end
        else
            player:completeMission(TOAU, tpz.mission.id.toau.EASTERLY_WINDS)
            player:addMission(TOAU, tpz.mission.id.toau.WESTERLY_WINDS)
            player:setCharVar("AhtUrganStatus", 0)
        end
    elseif csid == 10097 then
        player:completeMission(TOAU, tpz.mission.id.toau.ALLIED_RUMBLINGS)
        player:needToZone(true)
        player:setCharVar("TOAUM40_STARTDAY", VanadielDayOfTheYear())
        player:addMission(TOAU, tpz.mission.id.toau.UNRAVELING_REASON)
    elseif csid == 142 then
        player:addQuest(JEUNO, tpz.quest.id.jeuno.STORMS_OF_FATE)
    elseif csid == 143 then
        player:completeQuest(JEUNO, tpz.quest.id.jeuno.STORMS_OF_FATE)
        player:setCharVar('StormsOfFate', 0)
        player:setCharVar("StormsOfFateWait", getVanaMidnight())
    elseif csid == 161 then
        npcUtil.giveKeyItem(player, tpz.ki.NOTE_WRITTEN_BY_ESHANTARL)
        player:addQuest(JEUNO, tpz.quest.id.jeuno.SHADOWS_OF_THE_DEPARTED)
        player:setCharVar("StormsOfFateWait", 0)
    elseif csid == 162 then
        player:completeQuest(JEUNO, tpz.quest.id.jeuno.SHADOWS_OF_THE_DEPARTED)
        player:delKeyItem(tpz.ki.PROMYVION_HOLLA_SLIVER)
        player:delKeyItem(tpz.ki.PROMYVION_DEM_SLIVER)
        player:delKeyItem(tpz.ki.PROMYVION_MEA_SLIVER)
        player:messageSpecial(ID.text.YOU_HAND_THE_THREE_SLIVERS)
        player:setLocalVar('ANZONE', 1)
        player:setCharVar("ApocNighWait", getVanaMidnight())
    elseif csid == 123 then
        player:addQuest(JEUNO, tpz.quest.id.jeuno.APOCALYPSE_NIGH)
        player:setCharVar('ApocalypseNigh', 1)
        player:setCharVar("ApocNighWait", 0)
    end
end