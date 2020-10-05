-----------------------------------
-- Area: Metalworks
--  NPC: Ayame
-- Involved in Missions
-- Starts and Finishes Quest: True Strength
-- !pos 133 -19 34 237
-----------------------------------
local ID = require("scripts/zones/Metalworks/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/settings")
require("scripts/globals/quests")
require("scripts/globals/status")
require("scripts/globals/titles")
require("scripts/globals/utils")
-----------------------------------

function onTrade(player, npc, trade)

    if (player:getQuestStatus(BASTOK, tpz.quest.id.bastok.TRUE_STRENGTH) == QUEST_ACCEPTED) then
        if (trade:hasItemQty(1100, 1) and trade:getItemCount() == 1) then -- Trade Xalmo Feather
            player:startEvent(749) -- Finish Quest "True Strength"
        end
    end

end

function onTrigger(player, npc)

    local trueStrength = player:getQuestStatus(BASTOK, tpz.quest.id.bastok.TRUE_STRENGTH)
    local WildcatBastok = player:getCharVar("WildcatBastok")
    local FadedPromises = player:getQuestStatus(BASTOK, tpz.quest.id.bastok.FADED_PROMISES)

    if (player:getQuestStatus(BASTOK, tpz.quest.id.bastok.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and utils.mask.getBit(WildcatBastok, 9) == false) then
        player:startEvent(935)
    elseif (player:getCurrentMission(BASTOK) == tpz.mission.id.bastok.THE_CRYSTAL_LINE and player:hasKeyItem(tpz.ki.C_L_REPORTS)) then
        player:startEvent(712)
    elseif (trueStrength == QUEST_AVAILABLE and player:getMainJob() == tpz.job.MNK and player:getMainLvl() >= 50) then
        player:startEvent(748) -- Start Quest "True Strength"
    elseif (player:getCharVar("FadedPromises") == 1) then
        player:startEvent(803)
    elseif (player:getCharVar("FadedPromises") == 3) then
        player:startEvent(804)
    else
        player:startEvent(701) -- Standard dialog
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 712) then
        finishMissionTimeline(player, 1, csid, option)
    elseif (csid == 748) then
        player:addQuest(BASTOK, tpz.quest.id.bastok.TRUE_STRENGTH)
    elseif (csid == 749) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 14215) -- Temple Hose
        else
            player:tradeComplete()
            player:addTitle(tpz.title.PARAGON_OF_MONK_EXCELLENCE)
            player:addItem(14215)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 14215) -- Temple Hose
            player:addFame(BASTOK, 60)
            player:completeQuest(BASTOK, tpz.quest.id.bastok.TRUE_STRENGTH)
        end
    elseif (csid == 935) then
        player:setCharVar("WildcatBastok", utils.mask.setBit(player:getCharVar("WildcatBastok"), 9, true))
    elseif (csid == 803 and option == 1) then
        player:setCharVar("FadedPromises", 2)
    elseif (csid == 804) then
        player:setCharVar("FadedPromises", 4)
    end

end
