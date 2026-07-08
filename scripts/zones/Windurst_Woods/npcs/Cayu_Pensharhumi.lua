-----------------------------------
-- Area: Windurst Woods
--  NPC: Cayu Pensharhumi
-- !pos 39.437 -0.91 -40.808 241
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local wildcatWindurst = player:getCharVar('WildcatWindurst')

    if
        player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.LURE_OF_THE_WILDCAT) == xi.questStatus.QUEST_ACCEPTED and
        not utils.mask.getBit(wildcatWindurst, 2)
    then
        player:startEvent(733)
    else
        player:startEvent(259)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 733 then
        player:setCharVar('WildcatWindurst', utils.mask.setBit(player:getCharVar('WildcatWindurst'), 2, true))
    end
end

return entity
