-----------------------------------
-- ID: 16556
-- Item: Bloody Blade
-- Additional effect: en-drain
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemAdditionalEffect = function(actor, target, baseAttackDamage, item)
    local dStat = actor:getStat(xi.mod.INT) - target:getStat(xi.mod.INT)

    local pTable =
    {
        chance          = xi.additionalEffect.linearProcRate(dStat, 48, 10, 20),
        basePower       = 8 + utils.clamp(dStat, -3, 16) + utils.clamp(math.floor((dStat - 16) / 2), 0, 16),
        attackType      = xi.attackType.PHYSICAL,
        physicalElement = xi.damageType.SLASHING,
        magicalElement  = xi.element.DARK,
        canResist       = true,
        lowestResist    = 0.5,
        limitUndead     = true,
        drainHP         = true,
        overDrain       = true,
    }

    return xi.combat.action.executeAddEffectDamage(actor, target, pTable)
end

return itemObject
