-----------------------------------
-- Area: The Boyahda Tree
--   NM: Agas
-----------------------------------
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    if
        player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.SEARCHING_FOR_THE_RIGHT_WORDS) == QUEST_ACCEPTED and
        not player:hasKeyItem(xi.ki.MOONDROP)
    then
        player:setCharVar("Searching_AgasKilled", 1)
    end
end

return entity
