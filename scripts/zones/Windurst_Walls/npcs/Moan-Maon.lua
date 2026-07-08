-----------------------------------
-- Area: Windurst Walls
--  NPC: Moan-Maon
-- !pos 88.244 -6.32 148.912 239
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local wildcatWindurst = player:getCharVar('WildcatWindurst')

    if
        player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.LURE_OF_THE_WILDCAT) == xi.questStatus.QUEST_ACCEPTED and
        not utils.mask.getBit(wildcatWindurst, 7)
    then
        player:startEvent(497)
    else
        player:startEvent(307)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 497 then
        player:setCharVar('WildcatWindurst', utils.mask.setBit(player:getCharVar('WildcatWindurst'), 7, true))
    end
end

return entity
