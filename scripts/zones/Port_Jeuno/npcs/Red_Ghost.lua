-----------------------------------
-- Area: Port Jeuno
--  NPC: Red Ghost
-----------------------------------
local ID = require("scripts/zones/Port_Jeuno/IDs")
require("scripts/globals/pathfind")
require("scripts/globals/quests")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

local pathNodes =
{
    { x = -96, y = -0.001, z = 9, rotation = 192, wait = 4000 },
    { rotation = 64, wait = 1000 },
    { z = -9, rotation = 64, wait = 4000 },
    { rotation = 192, wait = 1000 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(pathNodes))
    npc:pathThrough(pathNodes, xi.path.flag.PATROL)
end

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local wildcatJeuno = player:getCharVar("WildcatJeuno")
    local fellowQuest = player:getCharVar("[Quest]Unlisted_Qualities")

    if
        player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and
        not utils.mask.getBit(wildcatJeuno, 15)
    then
        player:startEvent(314)
    elseif
        player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.UNLISTED_QUALITIES) == QUEST_ACCEPTED and
        not utils.mask.getBit(fellowQuest, 1)
    then
        player:startEvent(320, 0, 0, 0, 0, 0, 0, 0, player:getFellowValue("fellowid"))
    else
        player:startEvent(34)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 314 then
        player:setCharVar("WildcatJeuno", utils.mask.setBit(player:getCharVar("WildcatJeuno"), 15, true))
    elseif csid == 320 and option >= 0 and option <= 11 then
        local personality = { 4, 8, 12, 16, 40, 44, 20, 24, 28, 32, 36, 48 }
        player:setFellowValue("personality", personality[option + 1])
        player:setCharVar("[Quest]Unlisted_Qualities", utils.mask.setBit(player:getCharVar("[Quest]Unlisted_Qualities"), 1, true))
    end
end

--[[
Adventuring Fellow Personality Options:
    Male:
        0   Sullen
        1   Passionate
        2   Calm and collected
        3   Serious
        4   Childish
        5   Suave
    Female:
        6   Sisterly
        7   Lively
        8   Agreeable
        9   Naive
        10  Serious
        11  Domineering
--]]

return entity
