-----------------------------------
-- Area: Zhayolm Remnants
-- MOB: Ziz
-----------------------------------
local ID = zones[xi.zone.ZHAYOLM_REMNANTS]
mixins = { require('scripts/mixins/families/ziz') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setLocalVar('noSleep', 1)
    mob:setDelay(750)
    mob:setMod(xi.mod.ATT, 100)
    mob:setMod(xi.mod.MAIN_DMG_RATING, -15)
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        local instance = mob:getInstance()

        if instance then
            if xi.salvage.groupKilled(instance, ID.mob.ZIZ) then
                SpawnMob(ID.mob.POROGGO_GENT[2], instance):setDropID(2016)
            end
        end
    end
end

return entity
