-----------------------------------
-- ID: 18151
-- Item: Bloody Bolt
-- Additional effect: en-drain
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemAdditionalEffect = function(actor, target, baseAttackDamage, item)
    local dStat = actor:getStat(xi.mod.INT) - target:getStat(xi.mod.INT)
    -- Minimum observed at more than -100 dStat is 57. Negative dStat does seem to drop you to 57, but scaling is currently unknown.
    -- 92 is the upper cap starting at 48 dStat

    local pTable =
    {
        isRanged        = true,
        basePower       = 60 + utils.clamp(dStat, -3, 16) + utils.clamp(math.floor((dStat - 16) / 2), 0, 16),
        attackType      = xi.attackType.MAGICAL,
        magicalElement  = xi.element.DARK,
        canResist       = true,
        lowestResist    = 0.5,
        limitUndead     = true,
        drainHP         = true,
        overDrain       = true,
        animation       = xi.subEffect.HP_DRAIN,
    }

    return xi.combat.action.executeAddEffectDamage(actor, target, pTable)
end

return itemObject
