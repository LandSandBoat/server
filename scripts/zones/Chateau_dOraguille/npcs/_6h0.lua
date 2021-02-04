-----------------------------------
-- Area: Chateau d'Oraguille
-- Door: Prince Royal's
-- Finishes Quest: A Boy's Dream, Under Oath
-- Involved in Missions: 3-1, 5-2, 8-2
-- !pos -38 -3 73 233
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/quests")
require("scripts/globals/titles")
local ID = require("scripts/zones/Chateau_dOraguille/IDs")
-----------------------------------
local entity = {}

local function TrustMemory(player)
    local memories = 0
    -- 2 - LIGHTBRINGER
    if player:hasCompletedMission(tpz.mission.log_id.SANDORIA, tpz.mission.id.sandoria.LIGHTBRINGER) then
        memories = memories + 2
    end
    -- 4 - IMMORTAL_SENTRIES
    if player:hasCompletedMission(tpz.mission.log_id.TOAU, tpz.mission.id.toau.IMMORTAL_SENTRIES) then
        memories = memories + 4
    end
    -- 8 - UNDER_OATH
    if player:hasCompletedQuest(tpz.quest.log_id.SANDORIA, tpz.quest.id.sandoria.UNDER_OATH) then
        memories = memories + 8
    end
    -- 16 - FIT_FOR_A_PRINCE
    if player:hasCompletedQuest(tpz.quest.log_id.SANDORIA, tpz.quest.id.sandoria.FIT_FOR_A_PRINCE) then
        memories = memories + 16
    end
    -- 32 - Hero's Combat BCNM
    -- if (playervar for Hero's Combat) then
    --  memories = memories + 32
    -- end
    return memories
end

entity.onTrade = function(player, npc, trade)

end

entity.onTrigger = function(player, npc)
    local mLvl = player:getMainLvl()
    local aBoysDream = player:getQuestStatus(tpz.quest.log_id.SANDORIA, tpz.quest.id.sandoria.A_BOY_S_DREAM)
    local underOath = player:getQuestStatus(tpz.quest.log_id.SANDORIA, tpz.quest.id.sandoria.UNDER_OATH)

    -- "Under Oath" (PLD AF Body)
    if player:getCharVar("UnderOathCS") == 8 then
        player:startEvent(89)
    elseif
        player:getMainJob() == tpz.job.PLD and mLvl >= AF2_QUEST_LEVEL and
        aBoysDream == QUEST_COMPLETED and underOath == QUEST_AVAILABLE
    then
        player:startEvent(90) -- Start

    -- Trust: San d'Oria (Trion)
    elseif player:getRank() >= 6 and player:hasKeyItem(tpz.ki.SAN_DORIA_TRUST_PERMIT) and not player:hasSpell(905) then
        player:startEvent(574, 0, 0, 0, TrustMemory(player))

    -- "A Boy's Dream" (PLD AF Feet)
    elseif player:getCharVar("aBoysDreamCS") == 8 then
        player:startEvent(88)

    -- San d'Oria Rank 10 (different default)
    elseif player:getNation() == tpz.nation.SANDORIA and player:getRank() == 10 then
        player:startEvent(62)

    -- San d'Oria Missions
    elseif player:getNation() == tpz.nation.SANDORIA and player:getRank() ~= 10 then
        local sandyMissions = tpz.mission.id.sandoria
        local currentMission = player:getCurrentMission(SANDORIA)
        local missionStatus = player:getCharVar("MissionStatus")

        -- San d'Oria 9-2 "The Heir to the Light" (optional)
        if currentMission == sandyMissions.THE_HEIR_TO_THE_LIGHT and missionStatus > 5 then
            player:startEvent(3)

        -- San d'Oria 8-2 "Lightbringer" (optional)
        elseif
            player:getRank() == 9 and player:getRankPoints() == 0 and
            player:hasCompletedMission(tpz.mission.log_id.SANDORIA, sandyMissions.LIGHTBRINGER) and
            (player:getCharVar("Cutscenes_8-2") == 0 or player:getCharVar("Cutscenes_8-2") == 2)
        then
            player:startEvent(63)

        -- San d'Oria 6-2 "Ranperre's Final Rest"
        elseif currentMission == sandyMissions.RANPERRE_S_FINAL_REST then
            if missionStatus == 7 then
                player:startEvent(79) -- optional
            elseif missionStatus == 5 then
                player:startEvent(21)
            elseif missionStatus == 0 then
                player:startEvent(81)
            end

        -- San d'Oria 5-2 "The Shadow Lord"
        elseif currentMission == sandyMissions.THE_SHADOW_LORD and missionStatus == 1 then
            player:startEvent(547)

        -- San d'Oria 5-1 "The Ruins of Fei'Yin" (optional)
        elseif
            player:hasCompletedMission(tpz.mission.log_id.SANDORIA, sandyMissions.THE_RUINS_OF_FEI_YIN) and player:getRank() == 5 and
            currentMission ~= sandyMissions.THE_SHADOW_LORD
        then
            player:startEvent(115)

        -- San d'Oria 3-1 "Infiltrate Davoi"
        elseif currentMission == sandyMissions.INFILTRATE_DAVOI then
            if missionStatus == 4 then
                player:startEvent(554, 0, tpz.ki.ROYAL_KNIGHTS_DAVOI_REPORT)
            elseif missionStatus == 0 then
                player:startEvent(553, 0, tpz.ki.ROYAL_KNIGHTS_DAVOI_REPORT)
            end

        -- Default dialogue
        else
            player:startEvent(522)
        end
    else
        player:startEvent(522)
    end

    return 1
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)

    if (csid == 553) then
        player:setCharVar("MissionStatus", 2)
    elseif (csid == 547) then
        player:setCharVar("MissionStatus", 2)
    elseif (csid == 554) then
        finishMissionTimeline(player, 3, csid, option)
    elseif (csid == 88) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 14095)
        else
            if (player:getMainJob() == tpz.job.PLD) then
                player:addQuest(tpz.quest.log_id.SANDORIA, tpz.quest.id.sandoria.UNDER_OATH)
            end
            player:delKeyItem(tpz.ki.KNIGHTS_BOOTS)
            player:addItem(14095)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 14095) -- Gallant Leggings
            player:setCharVar("aBoysDreamCS", 0)
            player:addFame(SANDORIA, 40)
            player:completeQuest(tpz.quest.log_id.SANDORIA, tpz.quest.id.sandoria.A_BOY_S_DREAM)
        end
    elseif (csid == 90 and option == 1) then
        player:addQuest(tpz.quest.log_id.SANDORIA, tpz.quest.id.sandoria.UNDER_OATH)
        player:setCharVar("UnderOathCS", 0)
    elseif (csid == 89) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 12644)
        else
            player:addItem(12644)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 12644) -- Gallant Surcoat
            player:setCharVar("UnderOathCS", 9)
            player:addFame(SANDORIA, 60)
            player:setTitle(tpz.title.PARAGON_OF_PALADIN_EXCELLENCE)
            player:completeQuest(tpz.quest.log_id.SANDORIA, tpz.quest.id.sandoria.UNDER_OATH)
        end
    elseif (csid == 81) then
        player:setCharVar("MissionStatus", 1)
    elseif (csid == 21) then
        player:setCharVar("MissionStatus", 6)
    elseif (csid == 63) then
        player:setCharVar("Cutscenes_8-2", 1)
    elseif csid == 574 and option == 2 then
        player:addSpell(905, false, true)
        player:messageSpecial(ID.text.YOU_LEARNED_TRUST, 0, 905)
    end

end

return entity
