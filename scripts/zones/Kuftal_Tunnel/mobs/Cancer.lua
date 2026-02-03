-----------------------------------
-- Area: Kuftal Tunnel
--   NM: Cancer
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(xi.mobMod.GIL_MIN, 6000)
    mob:setMobMod(xi.mobMod.GIL_MAX, 9500)
end

entity.onAdditionalEffect = function(mob, target, damage)
    local pTable =
    {
        chance         = 25,
        attackType     = xi.attackType.MAGICAL,
        magicalElement = xi.element.WATER,
        basePower      = math.floor(damage / 2),
        actorStat      = xi.mod.INT,
    }

    return xi.combat.action.executeAddEffectDamage(mob, target, pTable)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 416)
end

return entity
