-----------------------------------
-- Area: Bibiki Bay
--   NM: Splacknuck
-----------------------------------
local ID = zones[xi.zone.BIBIKI_BAY]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  88.000, y = -45.000, z =  920.000 }
}

entity.phList =
{
    [ID.mob.SPLACKNUCK - 1] = ID.mob.SPLACKNUCK,
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.PLAGUE)
    mob:addImmunity(xi.immunity.GRAVITY)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 200)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 15)
    mob:setMod(xi.mod.TRIPLE_ATTACK, 15)
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

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 267)
end

return entity
