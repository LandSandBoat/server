-----------------------------------
-- Area: Norg
--  NPC: Mamaulabion
-- Starts and finishes Quest: Mama Mia
-- !pos -57 -9 68 252

--CSIDs for Mamaulabion
--93 / 93 = Standard
--191 / 191 = start quest
--192 / 192 = quest accepted
--193 / 193 = given an item
--194 / 194 = given an item you already gave
--195 / 195 = all 7 items given
--196 / 196 = after 7 items, but need more time until reward is given
--197 / 197 = reward
--198 / 198 = after quest is complete
--243 / 243 = get new ring if you dropped yours

--I did alot of copy/pasting, so you may notice a reduncency on comments XD
--But it can make it easier to follow aswell.

--"Mamaulabion will inform you of the items delivered thus far, as of the May 2011 update."
--i have no clue where this event is, so i have no idea how to add this (if this gets scripted, please remove this comment)

--"Upon completion of this quest, the above items no longer appear in the rewards list for defeating the Prime Avatars."
--will require changing other avatar quests and making a variable for it all. (if this gets scripted, please remove this comment)

-----------------------------------
local ID = require("scripts/zones/Norg/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if player:getQuestStatus(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.MAMA_MIA) == QUEST_ACCEPTED then
        -- check whether trade is an item with id 1202 to 1208
        local tradedItem
        local bitToSet
        for i = 1202, 1208 do
            if npcUtil.tradeHasExactly(trade, i) then
                tradedItem = i
                bitToSet = i - 1202
                break
            end
        end

        if tradedItem then
            local mask = player:getCharVar("tradesMamaMia")
            local wasSet = utils.mask.getBit(mask, bitToSet)

            if wasSet then
                player:startEvent(194) -- Traded an item you already gave
            else
                mask = utils.mask.setBit(mask, bitToSet, true)
                player:setCharVar("tradesMamaMia", mask)

                if utils.mask.isFull(mask, 7) then
                    player:startEvent(195) -- Traded all seven items
                else
                    player:startEvent(193) -- Traded an item
                end
            end
        end
    end
end

entity.onTrigger = function(player, npc)
    local mamaMia = player:getQuestStatus(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.MAMA_MIA)
    local moonlitPath = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.THE_MOONLIT_PATH)
    local evokersRing = player:hasItem(14625)
    local questday = player:getCharVar("MamaMia_date")

    if
        mamaMia == QUEST_AVAILABLE and
        player:getFameLevel(xi.quest.fame_area.NORG) >= 4 and
        moonlitPath == QUEST_COMPLETED
    then
        player:startEvent(191) -- Start Quest "Mama Mia"

    elseif mamaMia == QUEST_ACCEPTED then
        local tradesMamaMia = player:getCharVar("tradesMamaMia")

        if utils.mask.isFull(tradesMamaMia, 7) then
            if os.time() < questday then
                player:startEvent(196) --need to wait longer for reward
            else
                player:startEvent(197) --Reward
            end
        else
            player:startEvent(192) -- During Quest "Mama Mia"
        end

    elseif mamaMia == QUEST_COMPLETED and evokersRing then
        player:startEvent(198) -- New standard dialog after "Mama Mia" is complete

    elseif mamaMia == QUEST_COMPLETED and not evokersRing then
        player:startEvent(243) -- Quest completed, but dropped ring

    else
        player:startEvent(93) -- Standard dialog
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 191 then
        player:addQuest(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.MAMA_MIA)
    elseif csid == 193 then
        player:confirmTrade()
    elseif csid == 195 then
        player:confirmTrade()
        player:setCharVar("MamaMia_date", getMidnight())
    elseif csid == 197 then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 14625) -- Evokers Ring
        else
            player:addItem(14625) -- Evokers Ring
            player:messageSpecial(ID.text.ITEM_OBTAINED, 14625) -- Evokers Ring
            player:addFame(xi.quest.fame_area.NORG, 30) --idk how much fame the quest adds, just left at 30 which the levi quest gave.
            player:completeQuest(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.MAMA_MIA)
            player:setCharVar("tradesMamaMia", 0)
        end
    elseif csid == 243 then
        if option == 1 then
            player:delQuest(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.MAMA_MIA)
            player:addQuest(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.MAMA_MIA)
        end
    end
end

return entity
