-----------------------------------
-- Area: The Sanctuary of Zi'Tah
--   NM: Isonade
-- Involved in Quest: The Sacred Katana
-----------------------------------
require("scripts/globals/quests")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    if player:getQuestStatus(tpz.quest.log_id.OUTLANDS, tpz.quest.id.outlands.THE_SACRED_KATANA) == QUEST_ACCEPTED then
        player:setCharVar("IsonadeKilled", 1)
    end
end

return entity
