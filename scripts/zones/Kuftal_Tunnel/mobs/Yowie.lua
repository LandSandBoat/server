-----------------------------------
-- Area: Kuftal Tunnel
--   NM: Yowie
-----------------------------------
local ID = zones[xi.zone.KUFTAL_TUNNEL]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.YOWIE - 1] = ID.mob.YOWIE, -- Confirmed on retail
    [ID.mob.YOWIE - 3] = ID.mob.YOWIE, -- Confirmed on retail
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.TERROR)
    mob:setMobMod(xi.mobMod.GIL_MIN, 12000)
    mob:setMobMod(xi.mobMod.GIL_MAX, 12000)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.REGAIN, 25)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
end

entity.onAdditionalEffect = function(mob, target, damage)
    local pTable =
    {
        chance         = 20,
        attackType     = xi.attackType.MAGICAL,
        magicalElement = xi.element.EARTH,
        basePower      = math.floor(damage / 2),
        actorStat      = xi.mod.INT,
    }

    return xi.combat.action.executeAddEffectDamage(mob, target, pTable)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 419)
end

return entity
