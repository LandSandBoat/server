-----------------------------------
-- Area: Jugner Forest [S]
--   NM: Fingerfilcher Dradzad
-----------------------------------
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    if player:getQuestStatus(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.CLAWS_OF_THE_GRIFFON) == QUEST_ACCEPTED then
        player:setCharVar("FingerfilcherKilled", 1)
    end
end

return entity
