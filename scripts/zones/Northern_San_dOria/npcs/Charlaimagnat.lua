-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Charlaimagnat
-----------------------------------
local ID = zones[xi.zone.NORTHERN_SAN_DORIA]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local theMissingPiece = player:getQuestStatus(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.THE_MISSING_PIECE)

    if
        theMissingPiece == QUEST_ACCEPTED and
        player:hasKeyItem(xi.ki.TABLET_OF_ANCIENT_MAGIC) and
        player:hasKeyItem(xi.ki.LETTER_FROM_ALFESAR)
    then
        player:startEvent(703) -- Continuing the Quest
    elseif
        theMissingPiece == QUEST_ACCEPTED and
        os.time() < player:getCharVar('TheMissingPiece_date')
    then
        player:startEvent(704) -- didn't wait a day yet
    elseif
        theMissingPiece == QUEST_ACCEPTED and
        os.time() >= player:getCharVar('TheMissingPiece_date')
    then
        player:startEvent(705) -- Quest Completed
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 703 then
        player:setCharVar('TheMissingPiece_date', os.time() + 60)
        player:addTitle(xi.title.ACQUIRER_OF_ANCIENT_ARCANUM)
        player:delKeyItem(xi.ki.TABLET_OF_ANCIENT_MAGIC)
        player:delKeyItem(xi.ki.LETTER_FROM_ALFESAR)
    elseif csid == 705 then
        if player:getFreeSlotsCount() == 0 then -- does the player have space
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.SCROLL_OF_TELEPORT_ALTEP)
        else -- give player teleport-altep
            player:addItem(xi.item.SCROLL_OF_TELEPORT_ALTEP)
            player:messageSpecial(ID.text.ITEM_OBTAINED, xi.item.SCROLL_OF_TELEPORT_ALTEP)
            player:addFame(xi.quest.fame_area.SELBINA_RABAO, 30)
            player:completeQuest(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.THE_MISSING_PIECE)
        end
    end
end

return entity
