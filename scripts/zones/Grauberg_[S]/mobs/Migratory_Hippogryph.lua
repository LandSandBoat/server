-----------------------------------
-- Area: Grauberg [S]
--   NM: Migratory Hippogryph
-- Note: Spawned for quest "The Unfinished Waltz"
-----------------------------------
require("scripts/globals/quests")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.EXP_BONUS, -100)
end

function onMobDeath(mob, player, isKiller)
    if (player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.THE_UNFINISHED_WALTZ) == QUEST_ACCEPTED and player:getCharVar("QuestStatus_DNC_AF1") == 3) then
        player:setCharVar("QuestStatus_DNC_AF1", 4)
    end
end
