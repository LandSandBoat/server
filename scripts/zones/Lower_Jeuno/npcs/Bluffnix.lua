-----------------------------------
-- Area: Lower Jeuno
--  NPC: Bluffnix
-- Starts and Finishes Quests: Gobbiebags I-X
-- !pos -43.099 5.900 -114.788 245
-----------------------------------
local ID = require("scripts/zones/Lower_Jeuno/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/status")
require("scripts/globals/titles")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

-- key is current inventory size
local questData =
{
    [30] = {quest = xi.quest.id.jeuno.THE_GOBBIEBAG_PART_I,    fame = 3, trade = { 848,  652,  826,  788} },
    [35] = {quest = xi.quest.id.jeuno.THE_GOBBIEBAG_PART_II,   fame = 4, trade = { 851,  653,  827,  798} },
    [40] = {quest = xi.quest.id.jeuno.THE_GOBBIEBAG_PART_III,  fame = 5, trade = { 855,  745,  828,  797} },
    [45] = {quest = xi.quest.id.jeuno.THE_GOBBIEBAG_PART_IV,   fame = 5, trade = { 931,  654,  829,  808} },
    [50] = {quest = xi.quest.id.jeuno.THE_GOBBIEBAG_PART_V,    fame = 6, trade = {1637, 1635, 1636, 1634}, title = xi.title.GREEDALOX},
    [55] = {quest = xi.quest.id.jeuno.THE_GOBBIEBAG_PART_VI,   fame = 6, trade = {1741, 1738, 1739, 1740} },
    [60] = {quest = xi.quest.id.jeuno.THE_GOBBIEBAG_PART_VII,  fame = 7, trade = {2530,  655,  830,  812} },
    [65] = {quest = xi.quest.id.jeuno.THE_GOBBIEBAG_PART_VIII, fame = 7, trade = {2529, 2536, 2537,  813} },
    [70] = {quest = xi.quest.id.jeuno.THE_GOBBIEBAG_PART_IX,   fame = 8, trade = {2538,  747, 2704, 2743} },
    [75] = {quest = xi.quest.id.jeuno.THE_GOBBIEBAG_PART_X,    fame = 9, trade = {1459, 1711, 2705, 2744}, title = xi.title.GRAND_GREEDALOX},
}

entity.onTrade = function(player, npc, trade)
    local inventorySize = player:getContainerSize(xi.inv.INVENTORY)
    local data = questData[inventorySize]

    if
        data and
        player:getQuestStatus(xi.quest.log_id.JEUNO, data.quest) == QUEST_ACCEPTED
    then
        if npcUtil.tradeHas(trade, data.trade) then
            player:startEvent(73, inventorySize + 6)
        else
            player:startEvent(43, inventorySize + 1, 1, 1)
        end
    end
end

entity.onTrigger = function(player, npc)
    local lureOfTheWildcat = player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.LURE_OF_THE_WILDCAT)
    local wildcatJeuno = player:getCharVar("WildcatJeuno")
    local inventorySize = player:getContainerSize(xi.inv.INVENTORY)
    local data = questData[inventorySize]

    -- LURE OF THE WILDCAT
    if lureOfTheWildcat == QUEST_ACCEPTED and not utils.mask.getBit(WildcatJeuno, 12) then
        player:startEvent(10056)

    -- GOBBIEBAG QUESTS
    elseif inventorySize < 80 then
        if data then
            local arg2 = player:getQuestStatus(xi.quest.log_id.JEUNO, data.quest)
            local arg3 = player:getFameLevel(JEUNO) >= data.fame and 1 or 0

            player:startEvent(43, inventorySize + 1, arg2, arg3)
        end
    else
        player:startEvent(43, 81) -- Your bag's bigger than any gobbiebag I've ever seen
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    local inventorySize = player:getContainerSize(xi.inv.INVENTORY)
    local data = questData[inventorySize]

    -- GOBBIEBAG QUESTS
    if
        csid == 43 and
        option == 0 and
        data and
        player:getQuestStatus(xi.quest.log_id.JEUNO, data.quest) == QUEST_AVAILABLE and
        player:getFameLevel(JEUNO) >= data.fame
    then
        player:addQuest(xi.quest.log_id.JEUNO, data.quest)

    elseif
        csid == 73 and
        data and
        npcUtil.completeQuest(player, JEUNO, data.quest, {title = data.title})
    then
        player:changeContainerSize(xi.inv.INVENTORY, 5)
        player:changeContainerSize(xi.inv.MOGSATCHEL, 5)
        player:messageSpecial(ID.text.INVENTORY_INCREASED)
        player:confirmTrade()

    -- LURE OF THE WILDCAT
    elseif csid == 10056 then
        player:setCharVar("WildcatJeuno", utils.mask.setBit(player:getCharVar("WildcatJeuno"), 12, true))
    end
end

return entity
