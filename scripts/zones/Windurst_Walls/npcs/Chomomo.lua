-----------------------------------
-- Area: Windurst Walls
--  NPC: Chomomo
-- !pos -1.262 -11 290.224 239
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local wildcatWindurst = player:getCharVar('WildcatWindurst')

    if
        player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.LURE_OF_THE_WILDCAT) == xi.questStatus.QUEST_ACCEPTED and
        not utils.mask.getBit(wildcatWindurst, 8)
    then
        player:startEvent(499)
    else
        player:startEvent(325)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 499 then
        player:setCharVar('WildcatWindurst', utils.mask.setBit(player:getCharVar('WildcatWindurst'), 8, true))
    end
end

return entity
