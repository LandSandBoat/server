-----------------------------------
-- Area: Caedarva Mire
--  Mob: Caedarva Toad
-- Involved in Quest: The Wayward Automation
-----------------------------------
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    local theWaywardAutomaton = player:getQuestStatus(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.THE_WAYWARD_AUTOMATON)
    local theWaywardAutomatonProgress = player:getCharVar("TheWaywardAutomatonProgress")

    if
        theWaywardAutomaton == QUEST_ACCEPTED and
        theWaywardAutomatonProgress == 2 and
        player:getCharVar("TheWaywardAutomatonNM") == 0
    then
        player:setCharVar("TheWaywardAutomatonNM", 1)
    end
end

return entity
