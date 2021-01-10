-----------------------------------
-- Area: Jugner Forest [S]
--   NM: Fingerfilcher Dradzad
-----------------------------------
require("scripts/globals/quests")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    if player:getQuestStatus(tpz.quest.log_id.CRYSTAL_WAR, tpz.quest.id.crystalWar.CLAWS_OF_THE_GRIFFON) == QUEST_ACCEPTED then
        player:setCharVar("FingerfilcherKilled", 1)
    end
end

return entity
