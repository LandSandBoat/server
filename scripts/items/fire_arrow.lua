-----------------------------------
-- ID: 17322
-- Item: Fire Arrow
-- Additional effect: Fire damage
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
        magicalElement  = xi.element.FIRE,
        canResist       = true,
    }

    return xi.combat.action.executeAddEffectDamage(attacker, defender, pTable)
end

return itemObject
