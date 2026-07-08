-----------------------------------
-- ID: 17324
-- Item: Lightning Arrow
-- Additional effect: Lightning damage
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemAdditionalEffect = function(attacker, defender, baseAttackDamage, item)
    -- Unconfirmed power.
    local pTable =
    {
        isRanged        = true,
        basePower       = math.random(7, 10),
        attackType      = xi.attackType.PHYSICAL,
        physicalElement = xi.damageType.PIERCING,
        magicalElement  = xi.element.THUNDER,
        canResist       = true,
    }

    return xi.combat.action.executeAddEffectDamage(attacker, defender, pTable)
end

return itemObject
