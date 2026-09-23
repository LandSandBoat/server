-----------------------------------
-- Area: Beaucedine Glacier (111)
--   NM: Kirata
-----------------------------------
local ID = zones[xi.zone.BEAUCEDINE_GLACIER]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.KIRATA - 1] = ID.mob.KIRATA, -- Confirmed on retail
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    local pTable =
    {
        chance         = 100,
        attackType     = xi.attackType.MAGICAL,
        magicalElement = xi.element.WIND,
        basePower      = math.floor(damage / 2),
        actorStat      = xi.mod.INT,
    }

    return xi.combat.action.executeAddEffectDamage(mob, target, pTable)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 311)
    xi.magian.onMobDeath(mob, player, optParams, set{ 432 })
end

return entity
