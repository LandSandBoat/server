-----------------------------------
-- ID: 18359
-- Item: Mokusa
-- Additional effect: Wind damage
-----------------------------------
---@type TItem
local itemObject = {}

-- Made up values
itemObject.onItemAdditionalEffect = function(actor, target, baseAttackDamage, item)
    local pTable =
    {
        chance          = 5,
        basePower       = 19,
        attackType      = xi.attackType.MAGICAL,
        magicalElement  = xi.element.WIND,
        canResist       = true,
    }

    return xi.combat.action.executeAddEffectDamage(actor, target, pTable)
end

return itemObject
