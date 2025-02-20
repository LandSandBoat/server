-----------------------------------
-- Area: Tahrongi Canyon
--  NPC: Tahrongi Cacti
-- Involved in Quest: Say It with Flowers
-- !pos -308.721 7.477 264.454
-----------------------------------
local ID = zones[xi.zone.TAHRONGI_CANYON]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if
        player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.SAY_IT_WITH_FLOWERS) > xi.questStatus.QUEST_AVAILABLE and
        player:getCharVar('FLOWER_PROGRESS') == 3
    then
        if
            player:getFreeSlotsCount() > 0 and
            not player:hasItem(xi.item.TAHRONGI_CACTUS)
        then
            player:addItem(xi.item.TAHRONGI_CACTUS)
            player:messageSpecial(ID.text.BUD_BREAKS_OFF, 0, xi.item.TAHRONGI_CACTUS)
        else
            player:messageSpecial(ID.text.CANT_TAKE_ANY_MORE)
        end
    else
        player:messageSpecial(ID.text.POISONOUS_LOOKING_BUDS)
    end
end

return entity
