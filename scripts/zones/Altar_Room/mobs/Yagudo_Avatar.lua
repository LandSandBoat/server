-----------------------------------
-- Area: Altar Room 
-----------------------------------
local ID = require("scripts/zones/Altar_Room/IDs")
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/mobs")
-----------------------------------

function onMobSpawn(mob)
end

function onMobDeath(mob, player, isKiller)
    if player:getQuestStatus(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.A_MORAL_MANIFEST) == QUEST_ACCEPTED and
        player:getCharVar("moral") == 5 then
        player:setCharVar("moral", 6)
        player:delKeyItem(tpz.ki.VAULT_QUIPUS);
    end
    for i = ID.mob.YAGUDO_AVATAR + 1, ID.mob.YAGUDO_AVATAR + 8 do
        DespawnMob(i)
    end
end

function onMobDespawn(mob)
    for i = ID.mob.YAGUDO_AVATAR + 1, ID.mob.YAGUDO_AVATAR + 8 do
        DespawnMob(i)
    end
end
