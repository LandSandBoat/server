-----------------------------------
-- Area: Caedarva Mire
--  Mob: Caedarva Toad
-- Involved in Quest: The Wayward Automation
-----------------------------------
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    local theWaywardAutomation = player:getQuestStatus(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.THE_WAYWARD_AUTOMATON)
    local theWaywardAutomationProgress = player:getCharVar("TheWaywardAutomationProgress")

    if (theWaywardAutomation == QUEST_ACCEPTED and theWaywardAutomationProgress == 2 and player:getCharVar("TheWaywardAutomationNM") == 0) then
        player:setCharVar("TheWaywardAutomationNM", 1)
    end
end

return entity
