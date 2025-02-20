-----------------------------------
-- Area: Windurst Waters
--  NPC: Funpo-Shipo
-- !pos -44.091 -4.499 41.728 238
-----------------------------------
---@type TNpcEntity
local entity = {}

local pathNodes =
{
    { x = -27.810, y = -3.500, z = 40.957, wait = 6000 },
    { x = -46.663, z = 41.850, wait = 6000 },
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
        not utils.mask.getBit(wildcatWindurst, 13)
    then
        player:startEvent(938)
    else
        player:startEvent(576)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 938 then
        player:setCharVar('WildcatWindurst', utils.mask.setBit(player:getCharVar('WildcatWindurst'), 13, true))
    end
end

return entity
