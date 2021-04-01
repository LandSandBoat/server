-----------------------------------
-- Area: Grauberg [S]
--   NM: Migratory Hippogryph
-- Note: Spawned for quest "The Unfinished Waltz"
-----------------------------------
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.EXP_BONUS, -100)
end

entity.onMobDeath = function(mob, player, isKiller)
    if (player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.THE_UNFINISHED_WALTZ) == QUEST_ACCEPTED and player:getCharVar("QuestStatus_DNC_AF1") == 3) then
        player:setCharVar("QuestStatus_DNC_AF1", 4)
    end
end

return entity
