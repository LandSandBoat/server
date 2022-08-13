-----------------------------------
-- Area: Bastok Markets
--  NPC: Zon-Fobun
-- Type: Quest Giver
-- !pos -241.293 -3 63.406 235
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/pathfind")
-----------------------------------
local entity = {}

local path =
{
    -242.254, -2.000, 61.679,
    -242.254, -2.000, 61.679,
    -242.254, -2.000, 61.679,
    -242.254, -2.000, 61.679,
    -242.254, -2.000, 61.679,
    -242.254, -2.000, 61.679,
    -242.254, -2.000, 61.679,
    -240.300, -2.000, 65.194,
    -240.300, -2.000, 65.194,
    -240.300, -2.000, 65.194,
    -240.300, -2.000, 65.194,
    -240.300, -2.000, 65.194,
    -240.300, -2.000, 65.194,
    -240.300, -2.000, 65.194,
    -240.300, -2.000, 65.194,
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(path))
end

entity.onPath = function(npc)
    xi.path.patrol(npc, path)
end

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local cCollector = player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_CURSE_COLLECTOR)

    if cCollector == QUEST_AVAILABLE and player:getFameLevel(xi.quest.fame_area.BASTOK) >=4 then
        player:startEvent(251) -- Quest Start Dialogue
    elseif cCollector == QUEST_ACCEPTED and player:hasKeyItem(xi.ki.CURSEPAPER) and player:getCharVar("cCollectSilence") == 1 and player:getCharVar("cCollectCurse") == 1 then
        player:startEvent(252) -- Quest Completion Dialogue
    else
        player:startEvent(250)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 251 then
        player:addQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_CURSE_COLLECTOR)
        npcUtil.giveKeyItem(player, xi.ki.CURSEPAPER)
    elseif csid == 252 and npcUtil.completeQuest(player, xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_CURSE_COLLECTOR, {item = 16387, var = {"cCollectSilence", "cCollectCurse"}}) then
        player:delKeyItem(xi.ki.CURSEPAPER)
    end
end

return entity
