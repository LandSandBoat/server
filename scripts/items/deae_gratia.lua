-----------------------------------
-- ID: 18856
-- Item: Deae Gratia
-- Additional effect: en-drain
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemAdditionalEffect = function(actor, target, baseAttackDamage, item)
    local dStat = actor:getStat(xi.mod.INT) - target:getStat(xi.mod.INT)

    local pTable =
    {
        chance          = xi.additionalEffect.linearProcRate(dStat, 48, 22, 29),                              -- TODO: This actually caps above dINT 48 for proc rate
        basePower       = 30 + utils.clamp(dStat, -3, 16) + utils.clamp(math.floor((dStat - 16) / 2), 0, 16), -- TODO: check the scaling formula
        attackType      = xi.attackType.PHYSICAL,
        physicalElement = xi.damageType.BLUNT,
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
