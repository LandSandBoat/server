-----------------------------------
-- Area: Kazham
--  NPC: Gatih Mijurabi
-- !pos 58.249 -13.086 -49.084 250
-----------------------------------
local ID = zones[xi.zone.KAZHAM]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:getCharVar('BathedInScent') == 1 then
        if player:getQuestStatus(xi.questLog.OUTLANDS, xi.quest.id.outlands.PERSONAL_HYGIENE) == xi.questStatus.QUEST_AVAILABLE then
            player:startEvent(191)
        elseif player:getQuestStatus(xi.questLog.OUTLANDS, xi.quest.id.outlands.PERSONAL_HYGIENE) == xi.questStatus.QUEST_ACCEPTED then
            player:startEvent(192)
        else
            player:startEvent(195)
        end
    elseif
        player:getQuestStatus(xi.questLog.OUTLANDS, xi.quest.id.outlands.PERSONAL_HYGIENE) == xi.questStatus.QUEST_ACCEPTED and
        player:getCharVar('BathedInScent') == 0
    then
        player:startEvent(193)
    else
        player:startEvent(196)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 191 then
        player:addQuest(xi.questLog.OUTLANDS, xi.quest.id.outlands.PERSONAL_HYGIENE)
    elseif csid == 193 then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.MITHRAN_STONE)
        else
            player:completeQuest(xi.questLog.OUTLANDS, xi.quest.id.outlands.PERSONAL_HYGIENE)
            player:addItem(xi.item.MITHRAN_STONE)
            player:messageSpecial(ID.text.ITEM_OBTAINED, xi.item.MITHRAN_STONE)
        end
    end
end

return entity
