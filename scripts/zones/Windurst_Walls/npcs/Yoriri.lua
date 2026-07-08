-----------------------------------
-- Area: Windurst Walls
--  NPC: Yoriri
-- !pos 65.268 -8.5 -58.309 239
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local wildcatWindurst = player:getCharVar('WildcatWindurst')

    if
        player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.LURE_OF_THE_WILDCAT) == xi.questStatus.QUEST_ACCEPTED and
        not utils.mask.getBit(wildcatWindurst, 5)
    then
        player:startEvent(496)
    else
        player:startEvent(313)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 496 then
        player:setCharVar('WildcatWindurst', utils.mask.setBit(player:getCharVar('WildcatWindurst'), 5, true))
    end
end

return entity
