-----------------------------------
-- Area: Selbina
--  NPC: Isacio
-- Finishes Quest: Elder Memories
-- !pos -54 -1 -44 248
-----------------------------------
local ID = require("scripts/zones/Selbina/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/settings")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
    local questStatus = player:getQuestStatus(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.ELDER_MEMORIES)

    if questStatus == QUEST_ACCEPTED then
        local IsacioElderMemVar = player:getCharVar("IsacioElderMemVar")

        if IsacioElderMemVar == 1 and npcUtil.tradeHas(trade, 538) then
            player:startEvent(115, 537)
        elseif IsacioElderMemVar == 2 and npcUtil.tradeHas(trade, 537) then
            player:startEvent(116, 539)
        elseif IsacioElderMemVar == 3 and npcUtil.tradeHas(trade, 539) then
            player:startEvent(117)
        end
    end
end

function onTrigger(player, npc)
    local questStatus = player:getQuestStatus(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.ELDER_MEMORIES)

    if player:getQuestStatus(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.THE_OLD_LADY) ~= QUEST_AVAILABLE then
        player:startEvent(99)
    elseif questStatus == QUEST_COMPLETED then
        player:startEvent(118)
    elseif questStatus == QUEST_ACCEPTED then
        local IsacioElderMemVar = player:getCharVar("IsacioElderMemVar")

        if player:hasKeyItem(tpz.ki.GILGAMESHS_INTRODUCTORY_LETTER) then
            player:startEvent(117)
        elseif  IsacioElderMemVar == 1 then
            player:startEvent(114, 538)
        elseif IsacioElderMemVar == 2 then
            player:startEvent(114, 537)
        elseif IsacioElderMemVar == 3 then
            player:startEvent(114, 539)
        end
    else
        if player:getMainLvl() >= SUBJOB_QUEST_LEVEL then
            player:startEvent(111, 538)
        else
            player:startEvent(119)
        end
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 111 and option == 40 then
        player:addQuest(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.ELDER_MEMORIES)
        player:setCharVar("IsacioElderMemVar", 1)
    elseif csid == 115 then
        player:confirmTrade()
        player:setCharVar("IsacioElderMemVar", 2)
    elseif csid == 116 then
        player:confirmTrade()
        player:setCharVar("IsacioElderMemVar", 3)
    elseif csid == 117 then
        player:confirmTrade()
        player:unlockJob(0)
        player:setCharVar("IsacioElderMemVar", 0)
        player:messageSpecial(ID.text.SUBJOB_UNLOCKED)
        player:completeQuest(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.ELDER_MEMORIES)
    end
end
