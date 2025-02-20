-----------------------------------
-- Area: Windurst Waters
--  NPC: Npopo
-- !pos -35.464 -5.999 239.120 238
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local wildcatWindurst = player:getCharVar('WildcatWindurst')

    if
        player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.LURE_OF_THE_WILDCAT) == xi.questStatus.QUEST_ACCEPTED and
        not utils.mask.getBit(wildcatWindurst, 10)
    then
        player:startEvent(936)
    else
        player:startEvent(269)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 936 then
        player:setCharVar('WildcatWindurst', utils.mask.setBit(player:getCharVar('WildcatWindurst'), 10, true))
    end
end

return entity
