-----------------------------------
-- Area: Windurst Waters
--  NPC: Lago-Charago
-- Type: Adventurer's Assistant
-- !pos -57.271 -11.75 92.503 238
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local wildcatWindurst = player:getCharVar('WildcatWindurst')

    if
        player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.LURE_OF_THE_WILDCAT) == xi.questStatus.QUEST_ACCEPTED and
        not utils.mask.getBit(wildcatWindurst, 11)
    then
        player:startEvent(940)
    else
        player:startEvent(300)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 940 then
        player:setCharVar('WildcatWindurst', utils.mask.setBit(player:getCharVar('WildcatWindurst'), 11, true))
    end
end

return entity
