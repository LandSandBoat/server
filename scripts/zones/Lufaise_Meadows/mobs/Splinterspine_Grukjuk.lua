-----------------------------------
-- Area: Lufaise Meadows (24)
--  Mob: Splinterspine Grukjuk
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/status")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
end

function onMobDeath(mob, player, isKiller)
    if (player:getQuestStatus(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.A_HARD_DAY_S_KNIGHT) == QUEST_ACCEPTED) then
        player:setCharVar("SPLINTERSPINE_GRUKJUK", 2)
    end
end
