-----------------------------------
-- Area: Windurst Woods
--  NPC: Soni-Muni
-- Starts & Finishes Quest: The Amazin' Scorpio
-- !pos -17.073 1.749 -59.327 241
-----------------------------------
---@type TNpcEntity
local entity = {}

local pathNodes =
{
    { x = -18.366, y = 1.750, z = -59.804, wait = 8000 },
    { x = -18.303, y = 1.750, z = -59.925 },
    { x = -18.176, y = 1.750, z = -59.733 },
    { x = -17.620, y = 1.750, z = -59.529 },
    { x = -16.961, y = 1.750, z = -59.286 },
    { x = -16.590, y = 1.750, z = -59.149, wait = 8000 },
    { x = -16.961, y = 1.750, z = -59.286 },
    { x = -17.620, y = 1.750, z = -59.529 },
    { x = -18.176, y = 1.750, z = -59.733 },
    { x = -18.303, y = 1.750, z = -59.925 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(pathNodes))
    npc:pathThrough(pathNodes, xi.path.flag.PATROL)
end

entity.onTrade = function(player, npc, trade)
    if
        player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.THE_AMAZIN_SCORPIO) == xi.questStatus.QUEST_ACCEPTED and
        npcUtil.tradeHas(trade, xi.item.SCORPION_STINGER)
    then
        player:startEvent(484)
    end
end

entity.onTrigger = function(player, npc)
    local amazinScorpio = player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.THE_AMAZIN_SCORPIO)
    local wildcatWindurst = player:getCharVar('WildcatWindurst')

    if
        player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.LURE_OF_THE_WILDCAT) == xi.questStatus.QUEST_ACCEPTED and
        not utils.mask.getBit(wildcatWindurst, 0)
    then
        player:startEvent(735)
    elseif amazinScorpio == xi.questStatus.QUEST_COMPLETED then
        player:startEvent(485)
    elseif amazinScorpio == xi.questStatus.QUEST_ACCEPTED then
        player:startEvent(482, 0, 0, xi.item.SCORPION_STINGER)
    elseif
        amazinScorpio == xi.questStatus.QUEST_AVAILABLE and
        player:getFameLevel(xi.fameArea.WINDURST) >= 2
    then
        player:startEvent(481, 0, 0, xi.item.SCORPION_STINGER)
    else
        player:startEvent(421)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 481 then
        player:addQuest(xi.questLog.WINDURST, xi.quest.id.windurst.THE_AMAZIN_SCORPIO)
    elseif
        csid == 484 and
        npcUtil.completeQuest(player, xi.questLog.WINDURST, xi.quest.id.windurst.THE_AMAZIN_SCORPIO, { fame = 80, title = xi.title.GREAT_GRAPPLER_SCORPIO, gil = 1500 })
    then
        player:confirmTrade()
    elseif csid == 735 then
        player:setCharVar('WildcatWindurst', utils.mask.setBit(player:getCharVar('WildcatWindurst'), 0, true))
    end
end

return entity
