-----------------------------------
-- ID: 18698
-- Item: Water Arrow
-- Additional effect: Water damage
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemAdditionalEffect = function(attacker, defender, baseAttackDamage, item)
    local dStat = attacker:getStat(xi.mod.INT) - defender:getStat(xi.mod.INT)
    -- Unconfirmed power.

    local pTable =
    {
        isRanged        = true,
        basePower       = 10 + utils.clamp(dStat, -3, 8) + utils.clamp(math.floor((dStat - 8) / 2), 0, 8),
        attackType      = xi.attackType.PHYSICAL,
        physicalElement = xi.damageType.PIERCING,
        magicalElement  = xi.element.WATER,
        canResist       = true,
    }

    return xi.combat.action.executeAddEffectDamage(attacker, defender, pTable)
end

return itemObject
