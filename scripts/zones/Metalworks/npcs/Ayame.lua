-----------------------------------
-- Area: Metalworks
--  NPC: Ayame
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

entity.onTrade = function(player, npc, trade)
    if (player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.TRUE_STRENGTH) == QUEST_ACCEPTED) then
        if (trade:hasItemQty(1100, 1) and trade:getItemCount() == 1) then -- Trade Xalmo Feather
            player:startEvent(749) -- Finish Quest "True Strength"
        end
    end
end

entity.onTrigger = function(player, npc)
    local trueStrength = player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.TRUE_STRENGTH)

    if (trueStrength == QUEST_AVAILABLE and player:getMainJob() == xi.job.MNK and player:getMainLvl() >= 50) then
        player:startEvent(748) -- Start Quest "True Strength"
    elseif (player:getCharVar("FadedPromises") == 1) then
        player:startEvent(803)
    elseif (player:getCharVar("FadedPromises") == 3) then
        player:startEvent(804)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if (csid == 748) then
        player:addQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.TRUE_STRENGTH)
    elseif (csid == 749) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 14215) -- Temple Hose
        else
            player:tradeComplete()
            player:addTitle(xi.title.PARAGON_OF_MONK_EXCELLENCE)
            player:addItem(14215)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 14215) -- Temple Hose
            player:addFame(xi.quest.fame_area.BASTOK, 60)
            player:completeQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.TRUE_STRENGTH)
        end
    elseif (csid == 803 and option == 1) then
        player:setCharVar("FadedPromises", 2)
    elseif (csid == 804) then
        player:setCharVar("FadedPromises", 4)
    end
end

return entity
