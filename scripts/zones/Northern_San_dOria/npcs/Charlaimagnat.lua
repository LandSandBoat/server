-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Charlaimagnat
-- Standard Info NPC
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    local realday = tonumber(tostring(os.date("%Y")) .. os.date("%m") .. os.date("%d"))
    local TheMissingPiece = player:getQuestStatus(OUTLANDS, tpz.quest.id.outlands.THE_MISSING_PIECE)

    if (TheMissingPiece == QUEST_ACCEPTED and player:hasKeyItem(tpz.ki.TABLET_OF_ANCIENT_MAGIC) and player:hasKeyItem(tpz.ki.LETTER_FROM_ALFESAR)) then
        player:startEvent(703) -- Continuing the Quest
    elseif (TheMissingPiece == QUEST_ACCEPTED and realday < player:getCharVar("TheMissingPiece_date")) then
        player:startEvent(704) -- didn't wait a day yet
    elseif (TheMissingPiece == QUEST_ACCEPTED and realday >= player:getCharVar("TheMissingPiece_date")) then
        player:startEvent(705) -- Quest Completed
    else
        player:startEvent(702) -- standard dialogue
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 703) then
        player:setCharVar("TheMissingPiece_date", tostring(os.date("%Y")) .. os.date("%m") .. os.date("%d") + 1)
        player:addTitle(tpz.title.ACQUIRER_OF_ANCIENT_ARCANUM)
        player:delKeyItem(tpz.ki.TABLET_OF_ANCIENT_MAGIC)
        player:delKeyItem(tpz.ki.LETTER_FROM_ALFESAR)
    elseif (csid == 705) then
        if (player:getFreeSlotsCount() == 0) then -- does the player have space
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 4729)
        else -- give player teleport-altep
            player:addItem(4729)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 4729)
            player:addFame(RABAO, 30)
            player:completeQuest(OUTLANDS, tpz.quest.id.outlands.THE_MISSING_PIECE)
        end

    end
end
