-----------------------------------
-- ID: 17531
-- Item: Ramuh's Staff
-- Additional effect: lightning damage
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemAdditionalEffect = function(actor, target, baseAttackDamage, item)
    local dStat  = actor:getStat(xi.mod.INT) - target:getStat(xi.mod.INT)
    local chance = 3 -- TODO: check scaling on non-lightningday

    if VanadielDayOfTheWeek() == xi.day.LIGHTNINGDAY then
        chance = xi.additionalEffect.linearProcRate(dStat, 140, 15, 50) -- Numbers are smoothed out a bit. Scale from 15% at dINT 0 to 50% at +140 DINT
    end

    local pTable =
    {
        chance         = chance,
        basePower      = math.randomInt(18, 25),
        attackType     = xi.attackType.MAGICAL,
        magicalElement = xi.element.THUNDER,
        canMAB         = false,
        canResist      = true,
        lowestResist   = 0.5,
    }

    return xi.combat.action.executeAddEffectDamage(actor, target, pTable)
end

return itemObject
