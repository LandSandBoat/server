-----------------------------------
-- Area: Chateau d'Oraguille
--  NPC: Curilla
-- Starts and Finishes Quest: The General's Secret, Enveloped in Darkness, Peace for the Spirit,
--                            Lure of the Wildcat (San d'Oria), Old Wounds
-- !pos 27 0.1 0.1 233
-----------------------------------
local ID = require("scripts/zones/Chateau_dOraguille/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/settings")
require("scripts/globals/wsquest")
require("scripts/globals/quests")
require("scripts/globals/status")
require("scripts/globals/utils")
-----------------------------------

local wsQuest = tpz.wsquest.savage_blade
local questList = tpz.quest.id.sandoria

function onTrade(player, npc, trade)
    local wsQuestEvent = tpz.wsquest.getTradeEvent(wsQuest, player, trade)

    if wsQuestEvent ~= nil then
        player:startEvent(wsQuestEvent)
    end

end

function onTrigger(player, npc)
    local wsQuestEvent = tpz.wsquest.getTriggerEvent(wsQuest, player)
    local mLvl = player:getMainLvl()
    local mJob = player:getMainJob()
    local theGeneralSecret = player:getQuestStatus(SANDORIA, questList.THE_GENERAL_S_SECRET)
    local envelopedInDarkness = player:getQuestStatus(SANDORIA, questList.ENVELOPED_IN_DARKNESS)
    local peaceForTheSpirit = player:getQuestStatus(SANDORIA, questList.PEACE_FOR_THE_SPIRIT)

    -- "Lure of the Wildcat"
    if player:getQuestStatus(SANDORIA, questList.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and
        player:getMaskBit(player:getCharVar("WildcatSandy"), 15) == false
    then
        player:startEvent(562)

    -- "The General's Secret"
    -- [Blocks everything further down]
    elseif theGeneralSecret == QUEST_ACCEPTED then
        if player:hasKeyItem(tpz.ki.CURILLAS_BOTTLE_FULL) then
            player:startEvent(54)
        else
            player:startEvent(53)
        end
    elseif theGeneralSecret == QUEST_AVAILABLE and player:getFameLevel(SANDORIA) > 1 then
        player:startEvent(55) -- Start

    -- "Peace for the Spirit" (RDM AF Body)
    elseif peaceForTheSpirit == QUEST_ACCEPTED then
        local questStatus = player:getCharVar("peaceForTheSpiritCS")
        if questStatus == 5 then
            player:startEvent(51)
        elseif questStatus > 1 then
            player:startEvent(113)
        else
            player:startEvent(108)
        end
    elseif mJob == tpz.job.RDM and mLvl >= AF2_QUEST_LEVEL and envelopedInDarkness == QUEST_COMPLETED and
        peaceForTheSpirit == QUEST_AVAILABLE
    then
        player:startEvent(109) -- Start

    -- "Enveloped in Darkness" (RDM AF Shoes)
    elseif envelopedInDarkness == QUEST_ACCEPTED then
        if player:hasKeyItem(tpz.ki.OLD_POCKET_WATCH) and not player:hasKeyItem(tpz.ki.OLD_BOOTS) then
            player:startEvent(93)
        elseif player:hasKeyItem(tpz.ki.OLD_BOOTS) and player:getCharVar("needs_crawler_blood") == 0 then
            player:startEvent(101)
        elseif player:getCharVar("needs_crawler_blood") == 1 then
            player:startEvent(117)
        end
    elseif mJob == tpz.job.RDM and mLvl >= AF2_QUEST_LEVEL and
        player:getQuestStatus(SANDORIA, questList.THE_CRIMSON_TRIAL) == QUEST_COMPLETED and
        envelopedInDarkness == QUEST_AVAILABLE
    then
        player:startEvent(94) -- Start

    -- "Old Wounds" (Savage Blade WS)
    -- [Prioritize RDM Artifact; otherwise RDM AF will be blocked during the possibly extensive duration of this]
    elseif wsQuestEvent ~= nil then
        player:startEvent(wsQuestEvent)

    -- San d'Oria Missions (optional dialogues)
    elseif player:getNation() == tpz.nation.SANDORIA and
        (player:getCharVar("SandoEpilogue") == 1 or player:getRank() ~= 10)
    then
        local missions = tpz.mission.id.sandoria
        local currentMission = player:getCurrentMission(SANDORIA)
        local missionStatus = player:getCharVar("MissionStatus")

        -- San d'Oria Epilogue 
        if player:getRank() == 10 then
            player:startEvent(20)

        -- San d'Oria 9-2 "The Heir to the Light"
        elseif currentMission == missions.THE_HEIR_TO_THE_LIGHT and missionStatus > 1 then
            if missionStatus > 3 then
                player:startEvent(19)
            else
                player:startEvent(18)
            end

        -- San d'Oria 9-1 "Breaking Barrier"
        elseif player:hasCompletedMission(SANDORIA, missions.BREAKING_BARRIERS) and
            currentMission ~= missions.THE_HEIR_TO_THE_LIGHT
        then
            player:startEvent(16)

        -- San d'Oria 8-2 "Lightbringer"
        elseif currentMission == missions.LIGHTBRINGER and (missionStatus == 6 or missionStatus == 2) then
            if missionStatus == 6 then
                player:startEvent(103)
            else
                player:startEvent(57)
            end

        -- San d'Oria 5-2 "The Shadow Lord" (optional)
        elseif player:hasCompletedMission(SANDORIA, missions.THE_SHADOW_LORD) and player:getRank() == 6 and
            currentMission ~= missions.LEAUTE_S_LAST_WISHES
        then
            player:startEvent(56)

        -- San d'Oria 5-1 "The Ruins of Fei'Yin" (optional)
        elseif player:hasCompletedMission(SANDORIA, missions.THE_RUINS_OF_FEI_YIN) and player:getRank() == 5 and
            currentMission ~= missions.THE_SHADOW_LORD
        then
            player:startEvent(545)

        -- Default dialogue while doing missions
        else
            player:startEvent(530)
        end

    -- Default dialogue after "Peace for the Spirit"
    elseif peaceForTheSpirit == QUEST_COMPLETED then
        player:startEvent(52)

    -- Default dialogue after "Enveloped in Darkness"
    elseif envelopedInDarkness == QUEST_COMPLETED and peaceForTheSpirit == QUEST_AVAILABLE then
        player:startEvent(114)

    -- Default dialogue
    else
        player:startEvent(530)
    end

end

function onEventFinish(player, csid, option)
    if (csid == 55 and option == 1) then
        player:addQuest(SANDORIA, questList.THE_GENERAL_S_SECRET)
        player:addKeyItem(tpz.ki.CURILLAS_BOTTLE_EMPTY)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.CURILLAS_BOTTLE_EMPTY)
    elseif (csid == 54) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 16409) -- Lynx Baghnakhs
        else
            player:delKeyItem(tpz.ki.CURILLAS_BOTTLE_FULL)
            player:addItem(16409)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 16409) -- Lynx Baghnakhs
            player:addFame(SANDORIA, 30)
            player:completeQuest(SANDORIA, questList.THE_GENERAL_S_SECRET)
        end
    elseif (csid == 94 and option == 1) then
        player:addQuest(SANDORIA, questList.ENVELOPED_IN_DARKNESS)
        player:addKeyItem(tpz.ki.OLD_POCKET_WATCH)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.OLD_POCKET_WATCH)
    elseif (csid == 109 and option == 1) then
        player:addQuest(SANDORIA, questList.PEACE_FOR_THE_SPIRIT)
        player:setCharVar("needs_crawler_blood", 0)
    elseif (csid == 101) then
        player:setCharVar("needs_crawler_blood", 1)
    elseif (csid == 562) then
        player:setCharVar("WildcatSandy", utils.mask.setBit(player:getCharVar("WildcatSandy"), 15, true))
    else
        tpz.wsquest.handleEventFinish(wsQuest, player, csid, option, ID.text.SAVAGE_BLADE_LEARNED)
    end
end
