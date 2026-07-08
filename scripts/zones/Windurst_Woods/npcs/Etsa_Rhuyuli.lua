-----------------------------------
-- Area: Windurst Woods
--  NPC: Etsa Rhuyuli
-- !pos 62.482 -8.499 -139.836 241
-----------------------------------
---@type TNpcEntity
local entity = {}

local pathNodes =
{
    { x = 62.150, y = -7.500, z = -138.060 },
    { x = 62.843, z = -141.761 },
    { x = 63.382, z = -144.635 },
    { x = 62.843, z = -141.761 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(pathNodes))
    npc:pathThrough(pathNodes, xi.path.flag.PATROL)
end

entity.onTrigger = function(player, npc)
    local wildcatWindurst = player:getCharVar('WildcatWindurst')

    if
        player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.LURE_OF_THE_WILDCAT) == xi.questStatus.QUEST_ACCEPTED and
        not utils.mask.getBit(wildcatWindurst, 1)
    then
        player:startEvent(734)
    else
        player:startEvent(422)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 734 then
        player:setCharVar('WildcatWindurst', utils.mask.setBit(player:getCharVar('WildcatWindurst'), 1, true))
    end
end

return entity
