-----------------------------------
-- Area: Zhayolm Remnants
-- MOB: Puk
-----------------------------------
local ID = zones[xi.zone.ZHAYOLM_REMNANTS]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setDelay(700)
    mob:setMod(xi.mod.ATT, 75)
    mob:setMod(xi.mod.MAIN_DMG_RATING, -18)
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        local instance = mob:getInstance()

        if instance then
            if xi.salvage.groupKilled(instance, ID.mob.PUK) then
                SpawnMob(ID.mob.POROGGO_GENT[1], instance):setDropID(3376)
            end
        end
    end
end

return entity
