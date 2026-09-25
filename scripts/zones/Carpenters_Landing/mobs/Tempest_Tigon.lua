-----------------------------------
-- Area: Carpenters' Landing
--   NM: Tempest Tigon
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)

    mob:setRespawnTime(math.randomInt(900, 10800)) -- When server restarts, reset timer
end

entity.onAdditionalEffect = function(mob, target, damage)
    local pTable =
    {
        chance         = 50,
        attackType     = xi.attackType.MAGICAL,
        magicalElement = math.randomInt(1, 100) <= 50 and xi.element.WIND or xi.element.WATER,
        basePower      = math.floor(damage / 2),
        actorStat      = xi.mod.INT,
    }

    return xi.combat.action.executeAddEffectDamage(mob, target, pTable)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 168)
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.randomInt(3600, 7200)) -- 1 to 2 hours
end

return entity
