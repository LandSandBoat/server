-----------------------------------
-- ID: 17651
-- Item: Dainslaif
-- Additional effect: en-drain
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemAdditionalEffect = function(actor, target, baseAttackDamage, item)
    local dStat = actor:getStat(xi.mod.INT) - target:getStat(xi.mod.INT)

    local pTable =
    {
        chance          = 22, -- Observed rate is 21% which is close to (0.22 * .95) = 21%~ (resist roll failure)
        basePower       = 40 + utils.clamp(dStat, -3, 16) + utils.clamp(math.floor((dStat - 16) / 2), 0, 16),
        attackType      = xi.attackType.PHYSICAL,
        physicalElement = xi.damageType.SLASHING,
        magicalElement  = xi.element.DARK,
        canResist       = true,
        lowestResist    = 0.5,
        limitUndead     = true,
        drainHP         = true,
        overDrain       = true,
        animation       = xi.subEffect.DARKNESS_DAMAGE,
    }

    return xi.combat.action.executeAddEffectDamage(actor, target, pTable)
end

return itemObject
