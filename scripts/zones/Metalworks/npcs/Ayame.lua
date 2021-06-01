-----------------------------------
-- Area: Metalworks
--  NPC: Ayame
-- Involved in Missions
-- Starts and Finishes Quest: True Strength
-- !pos 133 -19 34 237
-----------------------------------
local ID = require("scripts/zones/Metalworks/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/magic")
require("scripts/globals/missions")
require("scripts/globals/settings")
require("scripts/globals/quests")
require("scripts/globals/status")
require("scripts/globals/titles")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

local TrustMemory = function(player)
    local memories = 0
    -- 2 - The Three Kingdoms
    if player:hasCompletedMission(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.JOURNEY_TO_BASTOK2) or
        player:hasCompletedMission(xi.mission.log_id.WINDURST, xi.mission.id.windurst.THE_THREE_KINGDOMS_BASTOK2) then
        memories = memories + 2
    end
    -- 4 - Where Two Paths Converge
    if player:hasCompletedMission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.WHERE_TWO_PATHS_CONVERGE) then
        memories = memories + 4
    end
    -- 8 - The Pirate's Cove
    if player:hasCompletedMission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.THE_PIRATE_S_COVE) then
        memories = memories + 8
    end
    -- 16 - Ayame and Kaede
    if player:hasCompletedQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.AYAME_AND_KAEDE) then
        memories = memories + 16
    end
    -- 32 - Light of Judgement
    if player:hasCompletedMission(xi.mission.log_id.TOAU, xi.mission.id.toau.LIGHT_OF_JUDGMENT) then
        memories = memories + 32
    end
    -- 64 - True Strength
    if player:hasCompletedQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.TRUE_STRENGTH) then
        memories = memories + 64
    end
    return memories
end

entity.onTrade = function(player, npc, trade)

    if (player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.TRUE_STRENGTH) == QUEST_ACCEPTED) then
        if (trade:hasItemQty(1100, 1) and trade:getItemCount() == 1) then -- Trade Xalmo Feather
            player:startEvent(749) -- Finish Quest "True Strength"
        end
    end

end

entity.onTrigger = function(player, npc)

    local trueStrength = player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.TRUE_STRENGTH)
    local WildcatBastok = player:getCharVar("WildcatBastok")
    local Rank3 = player:getRank(player:getNation()) >= 3 and 1 or 0

    if (player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and not utils.mask.getBit(WildcatBastok, 9)) then
        player:startEvent(935)
    elseif (player:getCurrentMission(BASTOK) == xi.mission.id.bastok.THE_CRYSTAL_LINE and
        player:hasKeyItem(xi.ki.C_L_REPORTS)) then
        player:startEvent(712)
    elseif (trueStrength == QUEST_AVAILABLE and player:getMainJob() == xi.job.MNK and player:getMainLvl() >= 50) then
        player:startEvent(748) -- Start Quest "True Strength"
    elseif (player:getCharVar("FadedPromises") == 1) then
        player:startEvent(803)
    elseif (player:getCharVar("FadedPromises") == 3) then
        player:startEvent(804)
    elseif
        player:hasKeyItem(xi.ki.BASTOK_TRUST_PERMIT) and
        not player:hasSpell(xi.magic.spell.AYAME) and
        player:getLocalVar("TrustDialogue") == 0
    then
        player:setLocalVar("TrustDialogue", 1)
        player:startEvent(985, 0, 0, 0, TrustMemory(player), 0, 0, 0, Rank3)
    else
        player:startEvent(701) -- Standard dialog
    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)

    if (csid == 712) then
        finishMissionTimeline(player, 1, csid, option)
    elseif (csid == 748) then
        player:addQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.TRUE_STRENGTH)
    elseif (csid == 749) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 14215) -- Temple Hose
        else
            player:tradeComplete()
            player:addTitle(xi.title.PARAGON_OF_MONK_EXCELLENCE)
            player:addItem(14215)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 14215) -- Temple Hose
            player:addFame(BASTOK, 60)
            player:completeQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.TRUE_STRENGTH)
        end
    elseif (csid == 935) then
        player:setCharVar("WildcatBastok", utils.mask.setBit(player:getCharVar("WildcatBastok"), 9, true))
    elseif (csid == 803 and option == 1) then
        player:setCharVar("FadedPromises", 2)
    elseif (csid == 804) then
        player:setCharVar("FadedPromises", 4)
    elseif csid == 985 and option == 2 then
        player:addSpell(900, true, true)
        player:messageSpecial(ID.text.YOU_LEARNED_TRUST, 0, 900)
    end

end

return entity
