-----------------------------------
-- Area: Altar Room
-----------------------------------
local ID = require("scripts/zones/Altar_Room/IDs")
mixins = { require("scripts/mixins/job_special") }
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
end

entity.onMobDeath = function(mob, player, optParams)
    if
        player:getQuestStatus(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.A_MORAL_MANIFEST) == QUEST_ACCEPTED and
        player:getCharVar("moral") == 5
    then
        player:setCharVar("moral", 6)
        player:delKeyItem(xi.ki.VAULT_QUIPUS)
    end

    for i = ID.mob.YAGUDO_AVATAR + 1, ID.mob.YAGUDO_AVATAR + 8 do
        DespawnMob(i)
    end
end

entity.onMobDespawn = function(mob)
    for i = ID.mob.YAGUDO_AVATAR + 1, ID.mob.YAGUDO_AVATAR + 8 do
        DespawnMob(i)
    end
end

return entity
