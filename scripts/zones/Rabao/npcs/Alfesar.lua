-----------------------------------
-- Area: Rabao
--  NPC: Alfesar
-- Standard Info NPC
--Starts The Missing Piece
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/shop")
require("scripts/globals/quests")
local ID = require("scripts/zones/Rabao/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)

    local TheMissingPiece = player:getQuestStatus(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.THE_MISSING_PIECE)
    local Fame = player:getFameLevel(RABAO)

    if (TheMissingPiece == QUEST_AVAILABLE and Fame >= 4) then -- start quest
        player:startEvent(6)
    elseif (TheMissingPiece == QUEST_ACCEPTED and not(player:hasKeyItem(xi.ki.ANCIENT_TABLET_FRAGMENT))) then -- talk to again with quest activated
        player:startEvent(7)
    elseif (TheMissingPiece == QUEST_ACCEPTED and player:hasKeyItem(xi.ki.ANCIENT_TABLET_FRAGMENT)) then -- successfully retrieve key item
        player:startEvent(8)
    elseif (TheMissingPiece == QUEST_ACCEPTED and player:hasKeyItem(xi.ki.TABLET_OF_ANCIENT_MAGIC)) then -- They got their Key items. tell them to goto sandy
        player:startEvent(9)
    else
        player:startEvent(52) -- standard dialogue
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if (csid == 6) then
        player:addQuest(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.THE_MISSING_PIECE)
    elseif (csid == 8) then -- give the player the key items he needs to complete the quest
        player:addKeyItem(xi.ki.TABLET_OF_ANCIENT_MAGIC)
        player:addKeyItem(xi.ki.LETTER_FROM_ALFESAR)
        player:delKeyItem(xi.ki.ANCIENT_TABLET_FRAGMENT)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.TABLET_OF_ANCIENT_MAGIC)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.LETTER_FROM_ALFESAR)
    end
end

return entity
