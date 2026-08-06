-----------------------------------
-- ID: 16528
-- Item: Bloody Rapier
-- Additional effect: en-drain
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemAdditionalEffect = function(actor, target, baseAttackDamage, item)
    local dStat = actor:getStat(xi.mod.INT) - target:getStat(xi.mod.INT)

    local pTable =
    {
        chance          = xi.additionalEffect.linearProcRate(dStat, 32, 8, 12), -- Needs better data, but looks like Bloody Blade's proc rate
        basePower       = 8 + utils.clamp(dStat, -3, 16) + utils.clamp(math.floor((dStat - 16) / 2), 0, 16),
        attackType      = xi.attackType.PHYSICAL,
        physicalElement = xi.damageType.PIERCING,
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
