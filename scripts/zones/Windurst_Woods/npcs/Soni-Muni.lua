-----------------------------------
-- Area: Windurst Woods
--  NPC: Soni-Muni
-- Starts & Finishes Quest: The Amazin' Scorpio
-- !pos -17.073 1.749 -59.327 241
-----------------------------------
require("scripts/globals/npc_util")
require("scripts/globals/pathfind")
require("scripts/globals/quests")
require("scripts/globals/titles")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

local path =
{
    -16.590, 1.750, -59.149,
    -18.366, 1.750, -59.804, -- TODO: Rotates towards R: 42 and waits 3 seconds
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(path))
end

entity.onPath = function(npc)
    xi.path.patrol(npc, path)
end

entity.onTrade = function(player, npc, trade)
    if player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.THE_AMAZIN_SCORPIO) == QUEST_ACCEPTED and npcUtil.tradeHas(trade, 1017) then
        player:startEvent(484)
    end
end

entity.onTrigger = function(player, npc)
    local amazinScorpio = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.THE_AMAZIN_SCORPIO)
    local wildcatWindurst = player:getCharVar("WildcatWindurst")

    if player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and not utils.mask.getBit(wildcatWindurst, 0) then
        player:startEvent(735)
    elseif amazinScorpio == QUEST_COMPLETED then
        player:startEvent(485)
    elseif amazinScorpio == QUEST_ACCEPTED then
        player:startEvent(482, 0, 0, 1017)
    elseif amazinScorpio == QUEST_AVAILABLE and player:getFameLevel(xi.quest.fame_area.WINDURST) >= 2 then
        player:startEvent(481, 0, 0, 1017)
    else
        player:startEvent(421)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 481 then
        player:addQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.THE_AMAZIN_SCORPIO)
    elseif csid == 484 and npcUtil.completeQuest(player, xi.quest.log_id.WINDURST, xi.quest.id.windurst.THE_AMAZIN_SCORPIO, {fame=80, title=xi.title.GREAT_GRAPPLER_SCORPIO, gil=1500}) then
        player:confirmTrade()
    elseif csid == 735 then
        player:setCharVar("WildcatWindurst", utils.mask.setBit(player:getCharVar("WildcatWindurst"), 0, true))
    end
end

return entity
