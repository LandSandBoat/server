-----------------------------------
-- Area: Lufaise Meadows (24)
--  Mob: Splinterspine Grukjuk
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
end

entity.onMobDeath = function(mob, player, isKiller)
    if (player:getQuestStatus(tpz.quest.log_id.OTHER_AREAS, tpz.quest.id.otherAreas.A_HARD_DAY_S_KNIGHT) == QUEST_ACCEPTED) then
        player:setCharVar("SPLINTERSPINE_GRUKJUK", 2)
    end
end

return entity
