-----------------------------------
-- ID: 16942
-- Item: Balmung
-- Additional effect: Dispel
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemAdditionalEffect = function(attacker, defender, baseAttackDamage, item)
    local pTable =
    {
        chance  = 10,
        element = xi.element.DARK,
    }

    return xi.combat.action.executeAddEffectDispel(attacker, defender, pTable)
end

return itemObject
