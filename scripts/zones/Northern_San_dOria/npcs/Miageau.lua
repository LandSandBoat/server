-----------------------------------
-- Area: Northern San d'Oria
--   NPC: Miageau
-- Type: Quest Giver NPC
-- !pos 115 0 108 231
--
-- Starts and Finishes: Waters of Cheval
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
require("scripts/globals/quests")
require("scripts/globals/titles")
-----------------------------------

function onTrade(player, npc, trade)
    if (player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.WATER_OF_THE_CHEVAL) == QUEST_ACCEPTED) then
        if (trade:getItemCount() == 1 and trade:hasItemQty(603, 1)) then
            player:startEvent(515)
        end
    end
end

function onTrigger(player, npc)

    local watersOfTheCheval = player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.WATER_OF_THE_CHEVAL)
    if (watersOfTheCheval == QUEST_ACCEPTED) then
        if (player:hasItem(602) == true) then
            player:startEvent(512)
        else
            player:startEvent(519)
        end
    elseif (watersOfTheCheval == QUEST_AVAILABLE) then
        player:startEvent(504)
    else
        player:startEvent(517)
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 515) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 13183)
        else
            player:tradeComplete()
            player:addItem(13183)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 13183)
            player:addFame(SANDORIA, 30)
            player:addTitle(tpz.title.THE_PURE_ONE)
            player:completeQuest(SANDORIA, tpz.quest.id.sandoria.WATER_OF_THE_CHEVAL)
        end
    elseif (csid == 504) then
        player:addQuest(SANDORIA, tpz.quest.id.sandoria.WATER_OF_THE_CHEVAL)
    end

end
