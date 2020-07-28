-----------------------------------
-- Area: Selbina
--  NPC: Valgeir
-- Involved in quests: "His Name is Valgeir", "Expertise", "The Basics"
-----------------------------------
local ID = require("scripts/zones/Selbina/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
    if player:getQuestStatus(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.EXPERTISE) == QUEST_ACCEPTED and npcUtil.tradeHas(trade, {4400, 4447}) then
        player:startEvent(103)
    end
end

function onTrigger(player, npc)
    local expertiseStat = player:getCharVar("QUEST_EXPERTISE_STATE_var")

    -- HIS NAME IS VALGEIR
    if player:getQuestStatus(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.HIS_NAME_IS_VALGEIR) == QUEST_ACCEPTED and player:hasKeyItem(tpz.ki.ARAGONEU_PIZZA) then
        player:startEvent(100)

    -- EXPERTISE
    elseif player:getQuestStatus(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.EXPERTISE) == QUEST_ACCEPTED and expertiseStat ~= 3 then
        if expertiseStat == 1 then
            player:startEvent(104)
        elseif expertiseStat == 2 then
            local daysPassed = VanadielDayOfTheYear() - player:getCharVar("QuestExpertiseDayStarted_var")
            local hoursLeft  = 24 - VanadielHour() - (daysPassed * 24) + player:getCharVar("QuestExpertiseHourStarted_var")

            if hoursLeft < 0 then -- done waiting
                player:startEvent(105)
            else
                player:startEvent(140) -- i am busy standard dialog
            end
        else
            player:startEvent(102, 4447, 4400) -- cook something for me
        end

    -- THE BASICS
    elseif player:getQuestStatus(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.THE_BASICS) == QUEST_ACCEPTED and player:hasKeyItem(tpz.ki.MHAURAN_COUSCOUS) then
        player:startEvent(106)
    elseif player:getQuestStatus(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.THE_BASICS) == QUEST_COMPLETED and player:getCharVar("QuestTheBacisCommentary_var") == 1 then
        player:startEvent(107)

    -- STANDARD DIALOG
    else
        player:startEvent(140)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    -- HIS NAME IS VALGEIR
    if csid == 100 then
        player:delKeyItem(tpz.ki.ARAGONEU_PIZZA)

    -- EXPERTISE
    elseif csid == 102 then
        player:setCharVar("QUEST_EXPERTISE_STATE_var", 1)
    elseif csid == 103 then -- now must wait 24 hours
        player:setCharVar("QUEST_EXPERTISE_STATE_var", 2)
        player:setCharVar("QuestExpertiseHourStarted_var", VanadielHour())
        player:setCharVar("QuestExpertiseDayStarted_var", VanadielDayOfTheYear())
        player:confirmTrade()
    elseif csid == 105 then -- done with the cooking
        npcUtil.giveKeyItem(player, tpz.ki.LAND_CRAB_BISQUE)
        player:setCharVar("QUEST_EXPERTISE_STATE_var", 3)
        player:setCharVar("QuestExpertiseHourStarted_var", 0)
        player:setCharVar("QuestExpertiseDayStarted_var", 0)

    -- THE BASICS
    elseif csid == 106 and npcUtil.giveItem(player, 4436) then
        player:setCharVar("QuestTheBacisCommentary_var", 1)
        player:delKeyItem(tpz.ki.MHAURAN_COUSCOUS)
    elseif csid == 107 then
        player:setCharVar("QuestTheBacisCommentary_var", 0)
    end
end
