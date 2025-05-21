-----------------------------------
-- Area: Zhayolm Remnants
-- MOB: Vagrant Lindwurm
-----------------------------------
local ID = zones[xi.zone.ZHAYOLM_REMNANTS]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setDelay(750)
    mob:setMod(xi.mod.ATT, 100)
    mob:setMod(xi.mod.MAIN_DMG_RATING, -15)
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        local instance = mob:getInstance()
        if instance then
            if xi.salvage.groupKilled(instance, ID.mob.VAGRANT_LINDWURM) then
                SpawnMob(ID.mob.POROGGO_GENT[3], instance):setDropID(3378)
            end
        end
    end
end

return entity
