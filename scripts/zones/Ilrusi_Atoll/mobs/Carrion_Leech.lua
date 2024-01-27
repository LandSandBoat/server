-----------------------------------
-- Area: Ilrusi Atoll (Extermination)
--  Mob: Carrion Leech
-----------------------------------
local ID = zones[xi.zone.ILRUSI_ATOLL]
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    local instance = mob:getInstance()
    local leechMob = GetMobByID(ID.mob.UNDEAD_LEECH, instance)
    local randVal  = math.random(1, 5)

    if randVal == 1 and leechMob:getLocalVar('LeechSpawned') == 0 then
        SpawnMob(ID.mob.UNDEAD_LEECH, instance)
        leechMob:setLocalVar('LeechSpawned', 1)
    else
        instance:setProgress(instance:getProgress() + 1)
    end
end

return entity
