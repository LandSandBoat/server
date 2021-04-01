-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Charlaimagnat
-- Standard Info NPC
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)

    local TheMissingPiece = player:getQuestStatus(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.THE_MISSING_PIECE)

    if (TheMissingPiece == QUEST_ACCEPTED and player:hasKeyItem(xi.ki.TABLET_OF_ANCIENT_MAGIC) and player:hasKeyItem(xi.ki.LETTER_FROM_ALFESAR)) then
        player:startEvent(703) -- Continuing the Quest
    elseif (TheMissingPiece == QUEST_ACCEPTED and os.time() < player:getCharVar("TheMissingPiece_date")) then
        player:startEvent(704) -- didn't wait a day yet
    elseif (TheMissingPiece == QUEST_ACCEPTED and os.time() >= player:getCharVar("TheMissingPiece_date")) then
        player:startEvent(705) -- Quest Completed
    else
        player:startEvent(702) -- standard dialogue
    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)

    if (csid == 703) then
        player:setCharVar("TheMissingPiece_date", os.time() + 60)
        player:addTitle(xi.title.ACQUIRER_OF_ANCIENT_ARCANUM)
        player:delKeyItem(xi.ki.TABLET_OF_ANCIENT_MAGIC)
        player:delKeyItem(xi.ki.LETTER_FROM_ALFESAR)
    elseif (csid == 705) then
        if (player:getFreeSlotsCount() == 0) then -- does the player have space
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 4729)
        else -- give player teleport-altep
            player:addItem(4729)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 4729)
            player:addFame(RABAO, 30)
            player:completeQuest(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.THE_MISSING_PIECE)
        end

    end
end

return entity
