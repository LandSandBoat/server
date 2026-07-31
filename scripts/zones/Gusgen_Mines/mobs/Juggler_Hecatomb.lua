-----------------------------------
-- Area: Gusgen Mines
--   NM: Juggler Hecatomb
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -138.198, y = 2.934, z = 335.708 },
    { x = -138.687, y = 1.662, z = 316.979 },
    { x = -120.535, y = 1.250, z = 325.704 },
    { x = -117.567, y = 1.000, z = 359.403 },
    { x = -137.270, y = 1.651, z = 361.399 },
    { x = -162.240, y = 1.000, z = 360.272 },
    { x = -163.992, y = 1.435, z = 346.388 },
    { x = -161.672, y = 1.104, z = 322.891 }
}

entity.onMobDespawn = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(math.randomInt(3600, 7200)) -- 1 to 2 hours
end

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1) -- Has an Additional Effect of Enwater on all attacks.
    mob:setMod(xi.mod.DOUBLE_ATTACK, 15)
end

entity.onAdditionalEffect = function(mob, target, damage)
    local pTable =
    {
        chance         = 100,
        attackType     = xi.attackType.MAGICAL,
        magicalElement = xi.element.WATER,
        basePower      = math.floor(damage / 2),
        actorStat      = xi.mod.INT,
    }

    return xi.combat.action.executeAddEffectDamage(mob, target, pTable)
end

return entity
