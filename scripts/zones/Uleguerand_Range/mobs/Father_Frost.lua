-----------------------------------
-- Area: Uleguerand Range
--   NM: Father Frost
-----------------------------------
local ID = zones[xi.zone.ULEGUERAND_RANGE]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.AUTO_SPIKES, 1)
    mob:addStatusEffect(xi.effect.ICE_SPIKES, { power = 50, origin = mob })
    mob:getStatusEffect(xi.effect.ICE_SPIKES):setEffectFlags(xi.effectFlag.DEATH)
end

entity.onSpikesDamage = function(mob, target, damage)
    local pTable =
    {
        basePower       = damage,
        attackType      = xi.attackType.MAGICAL,
        magicalElement  = xi.element.ICE,
        actorStat       = xi.mod.INT,
        canMAB          = true,
        canResist       = true,
        canResistExtra  = true,
    }

    return xi.combat.action.executeSpikesDamage(mob, target, pTable)
end

entity.onMobDespawn = function(mob)
    local ph = ID.mob.SNOW_MAIDEN - 1
    DisallowRespawn(ID.mob.FATHER_FROST, true)
    DisallowRespawn(ph, false)
    GetMobByID(ph):setRespawnTime(GetMobRespawnTime(ph))
end

return entity
