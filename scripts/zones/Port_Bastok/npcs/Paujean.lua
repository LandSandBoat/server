-----------------------------------
-- Area: Port Bastok
--  NPC: Paujean
-- Starts & Finishes Quest: Silence of the Rams
-- !pos -93.738 4.649 34.373 236
-----------------------------------
local ID = require("scripts/zones/Port_Bastok/IDs")
require("scripts/globals/settings")
require("scripts/globals/quests")
require("scripts/globals/titles")
-----------------------------------

function onTrade(player, npc, trade)
    local SilenceOfTheRams = player:getQuestStatus(BASTOK, tpz.quest.id.bastok.SILENCE_OF_THE_RAMS)

    if (SilenceOfTheRams == QUEST_ACCEPTED) then
        local count = trade:getItemCount()
        local LumberingHorn = trade:hasItemQty(910, 1)
        local RampagingHorn = trade:hasItemQty(911, 1)

        if (LumberingHorn == true and RampagingHorn == true and count == 2) then
            player:startEvent(196)
        end
    end
end

function onTrigger(player, npc)
    local SilenceOfTheRams = player:getQuestStatus(BASTOK, tpz.quest.id.bastok.SILENCE_OF_THE_RAMS)
    local WildcatBastok = player:getCharVar("WildcatBastok")

    if (player:getQuestStatus(BASTOK, tpz.quest.id.bastok.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and player:getMaskBit(WildcatBastok, 2) == false) then
        player:startEvent(355)
    elseif (SilenceOfTheRams == QUEST_AVAILABLE and player:getFameLevel(NORG) >= 2) then
        player:startEvent(195)
    elseif (SilenceOfTheRams == QUEST_ACCEPTED) then
        player:showText(npc, ID.text.PAUJEAN_DIALOG_1)
    else
        player:startEvent(25)
    end
end

function onEventUpdate(player, csid, option)
    -- printf("CSID2: %u", csid)
    -- printf("RESULT2: %u", option)
end

function onEventFinish(player, csid, option)
    if (csid == 195) then
        player:addQuest(BASTOK, tpz.quest.id.bastok.SILENCE_OF_THE_RAMS)
    elseif (csid == 196) then
        player:tradeComplete()
        player:completeQuest(BASTOK, tpz.quest.id.bastok.SILENCE_OF_THE_RAMS)
        player:addFame(3, 125)
        player:addItem(13201)
        player:messageSpecial(ID.text.ITEM_OBTAINED, 13201)
        player:addTitle(tpz.title.PURPLE_BELT)
    elseif (csid == 355) then
        player:setMaskBit(player:getCharVar("WildcatBastok"), "WildcatBastok", 2, true)
    end
end
