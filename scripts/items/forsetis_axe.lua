-----------------------------------
-- ID: 16726
-- Item: Forseti's Axe
-- Additional effect: Wind damage
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemAdditionalEffect = function(actor, target, baseAttackDamage, item)
    local dStat  = actor:getStat(xi.mod.INT) - target:getStat(xi.mod.INT)
    local chance = 3 -- TODO: check scaling on non-windssday
    local power  = 4 + utils.clamp(dStat * 35 / 54, 0, 35)

    if VanadielDayOfTheWeek() == xi.day.FIRESDAY then
        chance = xi.additionalEffect.linearProcRate(dStat, 140, 15, 50) -- Numbers are smoothed out a bit. Scale from 15% at dINT 0 to 50% at +140 DINT
    end

    local pTable =
    {
        chance         = chance,
        basePower      = math.randomInt(power, power + 3),
        attackType     = xi.attackType.MAGICAL,
        magicalElement = xi.element.WIND,
        canMAB         = false,
        canResist      = true,
    }

    return xi.combat.action.executeAddEffectDamage(actor, target, pTable)
end

return itemObject
