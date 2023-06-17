-----------------------------------
-- Area: Rabao
--  NPC: Alfesar
--Starts The Missing Piece
-----------------------------------
require("scripts/globals/shop")
require("scripts/globals/quests")
local ID = require("scripts/zones/Rabao/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local theMissingPiece = player:getQuestStatus(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.THE_MISSING_PIECE)
    local fame = player:getFameLevel(xi.quest.fame_area.SELBINA_RABAO)

    if theMissingPiece == QUEST_AVAILABLE and fame >= 4 then -- start quest
        player:startEvent(6)
    elseif
        theMissingPiece == QUEST_ACCEPTED and
        not player:hasKeyItem(xi.ki.ANCIENT_TABLET_FRAGMENT)
    then
        -- talk to again with quest activated
        player:startEvent(7)
    elseif
        theMissingPiece == QUEST_ACCEPTED and
        player:hasKeyItem(xi.ki.ANCIENT_TABLET_FRAGMENT)
    then
        -- successfully retrieve key item
        player:startEvent(8)
    elseif
        theMissingPiece == QUEST_ACCEPTED and
        player:hasKeyItem(xi.ki.TABLET_OF_ANCIENT_MAGIC)
    then
        -- They got their Key items. tell them to goto sandy
        player:startEvent(9)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 6 then
        player:addQuest(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.THE_MISSING_PIECE)
    elseif csid == 8 then -- give the player the key items he needs to complete the quest
        player:addKeyItem(xi.ki.TABLET_OF_ANCIENT_MAGIC)
        player:addKeyItem(xi.ki.LETTER_FROM_ALFESAR)
        player:delKeyItem(xi.ki.ANCIENT_TABLET_FRAGMENT)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.TABLET_OF_ANCIENT_MAGIC)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.LETTER_FROM_ALFESAR)
    end
end

return entity
