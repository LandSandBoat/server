-----------------------------------
-- Area: Windurst Waters
--  NPC: Amagusa-Chigurusa
-- !pos -28.746 -4.5 61.954 238
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local wildcatWindurst = player:getCharVar('WildcatWindurst')

    if
        player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.LURE_OF_THE_WILDCAT) == xi.questStatus.QUEST_ACCEPTED and
        not utils.mask.getBit(wildcatWindurst, 12)
    then
        player:startEvent(937)
    else
        player:startEvent(562)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 937 then
        player:setCharVar('WildcatWindurst', utils.mask.setBit(player:getCharVar('WildcatWindurst'), 12, true))
    end
end

return entity
