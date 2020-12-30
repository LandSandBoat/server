-----------------------------------
-- Area: The Boyahda Tree
--   NM: Agas
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/quests")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    if player:getQuestStatus(tpz.quest.log_id.JEUNO, tpz.quest.id.jeuno.SEARCHING_FOR_THE_RIGHT_WORDS) == QUEST_ACCEPTED and not player:hasKeyItem(tpz.ki.MOONDROP) then
        player:setCharVar("Searching_AgasKilled", 1)
    end
end
