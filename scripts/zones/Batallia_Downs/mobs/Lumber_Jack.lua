-----------------------------------
-- Area: Batallia Downs (105)
--   NM: Lumber Jack
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 600)
    mob:setMobMod(xi.mobMod.GIL_MIN, 20000)
    mob:setMobMod(xi.mobMod.GIL_MAX, 20000)
    mob:setMobMod(xi.mobMod.MUG_GIL, 7500)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.SLOW)
    mob:addImmunity(xi.immunity.ELEGY)
    mob:addImmunity(xi.immunity.PETRIFY)
    -- TODO: BIND or ICE resistance rank
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
    mob:setMod(xi.mod.UFASTCAST, 85)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 10)
    mob:setMod(xi.mod.POWER_MULTIPLIER_SPELL, 25)
end

entity.onAdditionalEffect = function(mob, target, damage)
    local pTable =
    {
        chance    = 20,
        effectId  = xi.effect.STUN,
        duration  = 10,
        animation = 0,
        message   = 0,
    }

    return xi.combat.action.executeAddEffectEnfeeblement(mob, target, pTable)
end

entity.onMobDeath = function(mob, player, optParams)
    mob:setLocalVar('death', 1)
end

entity.onMobDespawn = function(mob)
    local lumberDeath = mob:getLocalVar('death')

    if lumberDeath then
        -- Lumber Jack died, Set Weeping Willow's respawn time (21-24 hours)
        GetMobByID(mob:getID() -6):setRespawnTime(math.random(75600, 86400))
    else
        -- Lumber Jack idle despawned, set Weeping Willow to 30 min respawn
        GetMobByID(mob:getID() -6):setRespawnTime(1800)
    end
end

return entity
