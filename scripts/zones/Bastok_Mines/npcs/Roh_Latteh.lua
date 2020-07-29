-----------------------------------
-- Area: Bastok Mines
--  NPC: Roh Latteh
-- Involved in Quest: Mom, The Adventurer?
-- Finishes Quest: The Signpost Marks the Spot
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/titles")
require("scripts/globals/quests")
local ID = require("scripts/zones/Bastok_Mines/IDs")
-----------------------------------

function onTrade(player, npc, trade)

    if (player:getQuestStatus(BASTOK, tpz.quest.id.bastok.MOM_THE_ADVENTURER) ~= QUEST_AVAILABLE and player:getCharVar("MomTheAdventurer_Event") == 1) then
        if (trade:hasItemQty(13454, 1) and trade:getItemCount() == 1) then -- Trade Copper Ring
            player:startEvent(95)
        end
    end

end

function onTrigger(player, npc)
    local HasPainting = player:hasKeyItem(tpz.ki.PAINTING_OF_A_WINDMILL)

    if (player:getQuestStatus(BASTOK, tpz.quest.id.bastok.THE_SIGNPOST_MARKS_THE_SPOT) == QUEST_ACCEPTED and HasPainting == true) then
        player:startEvent(96)
    else
        player:startEvent(29)
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 95) then
        player:addKeyItem(tpz.ki.LETTER_FROM_ROH_LATTEH)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.LETTER_FROM_ROH_LATTEH)
        player:setCharVar("MomTheAdventurer_Event", 2)
        player:tradeComplete()
    elseif (csid == 96) then
        local freeInventory = player:getFreeSlotsCount()

        if (freeInventory > 0) then
            player:completeQuest(BASTOK, tpz.quest.id.bastok.THE_SIGNPOST_MARKS_THE_SPOT)
            player:delKeyItem(tpz.ki.PAINTING_OF_A_WINDMILL)
            player:addTitle(tpz.title.TREASURE_SCAVENGER)
            player:addFame(BASTOK, 50)
            player:addItem(12601)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 12601) -- Linen Robe
        else
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 12601)
        end
    end

end
