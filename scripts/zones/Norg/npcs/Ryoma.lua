-----------------------------------
-- Area: Norg
--  NPC: Ryoma
-- Start and Finish Quest: 20 in Pirate Years, I'll Take the Big Box, True Will, Bugi Soden
-- Involved in Quest: Ayame and Kaede
-- !pos -23 0 -9 252
-----------------------------------
local ID = require("scripts/zones/Norg/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/settings")
require("scripts/globals/wsquest")
require("scripts/globals/quests")
require("scripts/globals/status")
require("scripts/globals/shop")
-----------------------------------

local wsQuest = tpz.wsquest.blade_ku

function onTrade(player, npc, trade)
    local wsQuestEvent = tpz.wsquest.getTradeEvent(wsQuest, player, trade)

    if (wsQuestEvent ~= nil) then
        player:startEvent(wsQuestEvent)
    end
end

function onTrigger(player, npc)
    local wsQuestEvent = tpz.wsquest.getTriggerEvent(wsQuest, player)
    local twentyInPirateYears = player:getQuestStatus(OUTLANDS, tpz.quest.id.outlands.TWENTY_IN_PIRATE_YEARS)
    local illTakeTheBigBox = player:getQuestStatus(OUTLANDS, tpz.quest.id.outlands.I_LL_TAKE_THE_BIG_BOX)
    local trueWill = player:getQuestStatus(OUTLANDS, tpz.quest.id.outlands.TRUE_WILL)
    local mLvl = player:getMainLvl()
    local mJob = player:getMainJob()

    if (wsQuestEvent ~= nil) then
        player:startEvent(wsQuestEvent)
    elseif (player:getQuestStatus(BASTOK, tpz.quest.id.bastok.AYAME_AND_KAEDE) == QUEST_ACCEPTED) then
        if (player:getCharVar("AyameAndKaede_Event") == 3) then
            player:startEvent(95) -- During Quest "Ayame and Kaede"
        else
            player:startEvent(94)
        end
    elseif (twentyInPirateYears == QUEST_AVAILABLE and mJob == tpz.job.NIN and mLvl >= 40) then
        player:startEvent(133) -- Start Quest "20 in Pirate Years"
    elseif (twentyInPirateYears == QUEST_ACCEPTED and player:hasKeyItem(tpz.ki.TRICK_BOX)) then
        player:startEvent(134) -- Finish Quest "20 in Pirate Years"
    elseif (twentyInPirateYears == QUEST_COMPLETED and illTakeTheBigBox == QUEST_AVAILABLE and mJob == tpz.job.NIN and mLvl >= 50 and player:needToZone() == false) then
        player:startEvent(135) -- Start Quest "I'll Take the Big Box"
    elseif (illTakeTheBigBox == QUEST_COMPLETED and trueWill == QUEST_AVAILABLE) then
        player:startEvent(136) -- Start Quest "True Will"
    elseif (player:hasKeyItem(tpz.ki.OLD_TRICK_BOX) and player:getCharVar("trueWillCS") == 0) then
        player:startEvent(137)
    elseif (player:getCharVar("trueWillCS") == 1) then
        player:startEvent(138)
    else
        player:startEvent(94)
    end

end

function onEventFinish(player, csid, option)
    if (csid == 95) then
        player:addKeyItem(tpz.ki.SEALED_DAGGER)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.SEALED_DAGGER)
        player:delKeyItem(tpz.ki.STRANGELY_SHAPED_CORAL)
        player:setCharVar("AyameAndKaede_Event", 4)
    elseif (csid == 133) then
        player:addQuest(OUTLANDS, tpz.quest.id.outlands.TWENTY_IN_PIRATE_YEARS)
        player:setCharVar("twentyInPirateYearsCS", 1)
    elseif (csid == 134) then
        if (player:getFreeSlotsCount() <= 1) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 17771)
        else
            player:delKeyItem(tpz.ki.TRICK_BOX)
            player:addItem(17771)
            player:addItem(17772)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 17771) -- Anju
            player:messageSpecial(ID.text.ITEM_OBTAINED, 17772) -- Zushio
            player:needToZone()
            player:setCharVar("twentyInPirateYearsCS", 0)
            player:addFame(NORG, 30)
            player:completeQuest(OUTLANDS, tpz.quest.id.outlands.TWENTY_IN_PIRATE_YEARS)
        end
    elseif (csid == 135) then
        player:addQuest(OUTLANDS, tpz.quest.id.outlands.I_LL_TAKE_THE_BIG_BOX)
    elseif (csid == 136) then
        player:addQuest(OUTLANDS, tpz.quest.id.outlands.TRUE_WILL)
    elseif (csid == 137) then
        player:setCharVar("trueWillCS", 1)
    else
        tpz.wsquest.handleEventFinish(wsQuest, player, csid, option, ID.text.BLADE_KU_LEARNED)
    end
end
