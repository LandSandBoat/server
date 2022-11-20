-----------------------------------
-- Area: Sauromugue Champaign [S]
--  NPC: Indescript Markings
-- !pos 322 24 113
-- Quest NPC
-----------------------------------
require("scripts/globals/campaign")
require("scripts/globals/titles")
require("scripts/globals/quests")
require("scripts/globals/settings")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if
        player:getQuestStatus(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.DOWNWARD_HELIX) == QUEST_ACCEPTED and
        player:getCharVar("DownwardHelix") == 3
    then
        player:startEvent(4)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 4 then
        player:setCharVar("DownwardHelix", 4)
    end
end

return entity
