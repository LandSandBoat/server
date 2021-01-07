-----------------------------------
-- Area: Jugner Forest [S]
--  Mob: Cobraclaw Buchzvotch
-- Wrath of the Griffon Fight
-----------------------------------
require("scripts/globals/quests")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    if player:getQuestStatus(tpz.quest.log_id.CRYSTAL_WAR, tpz.quest.id.crystalWar.WRATH_OF_THE_GRIFFON) == QUEST_ACCEPTED then
        player:setCharVar("CobraClawKilled", 1)
    end
end

return entity
