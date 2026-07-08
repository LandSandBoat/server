-----------------------------------
-- ID: 22287
-- Item: Scouts Bolt
-- Additional effect: Light damage
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemAdditionalEffect = function(attacker, defender, baseAttackDamage, item)
    local dStat = attacker:getStat(xi.mod.MND) - defender:getStat(xi.mod.MND)
    -- Unconfirmed power.

    local pTable =
    {
        isRanged        = true,
        basePower       = 40 + utils.clamp(dStat, -3, 8) + utils.clamp(math.floor((dStat - 8) / 2), 0, 8),
        attackType      = xi.attackType.PHYSICAL,
        physicalElement = xi.damageType.PIERCING,
        magicalElement  = xi.element.LIGHT,
        canResist       = true,
    }

    return xi.combat.action.executeAddEffectDamage(attacker, defender, pTable)
end

return itemObject
