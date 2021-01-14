-----------------------------------
-- Area: Caedarva Mire
--  Mob: Caedarva Toad
-- Involved in Quest: The Wayward Automation
-----------------------------------
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)

    local TheWaywardAutomation = player:getQuestStatus(tpz.quest.log_id.AHT_URHGAN, tpz.quest.id.ahtUrhgan.THE_WAYWARD_AUTOMATION)
    local TheWaywardAutomationProgress = player:getCharVar("TheWaywardAutomationProgress")

    if (TheWaywardAutomation == QUEST_ACCEPTED and TheWaywardAutomationProgress == 2 and player:getCharVar("TheWaywardAutomationNM") == 0) then
        player:setCharVar("TheWaywardAutomationNM", 1)
    end
end

return entity
