-----------------------------------
-- Area: Labyrinth of Onzozo
--   NM: Hellion
-----------------------------------
local ID = zones[xi.zone.LABYRINTH_OF_ONZOZO]
-----------------------------------
---@type TMobEntity
local entity = {}

-- Hellion does not spawn near its PHs.

entity.spawnPoints =
{
    { x =  97.454, y = 14.882, z = 58.474 },
    { x =  98.482, y = 14.868, z = 64.923 },
    { x = 109.078, y = 15.216, z = 61.308 },
    { x = 102.868, y = 15.368, z = 61.308 },
    { x =  89.113, y = 14.437, z = 61.137 }
}

entity.phList =
{
    [ID.mob.HELLION + 2 ] = ID.mob.HELLION, -- 136.566 14.708 70.077
    [ID.mob.HELLION + 15] = ID.mob.HELLION, -- 127.523 14.327 210.258
}

entity.onMobInitialize = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)

    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.TERROR)

    mob:setMobMod(xi.mobMod.GIL_MIN, 12000)
    mob:setMobMod(xi.mobMod.GIL_MAX, 12000)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
end

entity.onAdditionalEffect = function(mob, target, damage)
    local pTable =
    {
        chance         = 100,
        attackType     = xi.attackType.MAGICAL,
        magicalElement = xi.element.DARK,
        basePower      = damage / 2,
        actorStat      = xi.mod.INT,
    }

    return xi.combat.action.executeAdditionalDamage(mob, target, pTable)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 296)
end

entity.onMobDespawn = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
end

return entity
