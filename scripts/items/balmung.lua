-----------------------------------
-- ID: 16942
-- Item: Balmung
-- Additional effect: Dispel
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemAdditionalEffect = function(actor, target, baseAttackDamage, item)
    local pTable =
    {
        chance         = 10,
        magicalElement = xi.element.DARK,
    }

    return xi.combat.action.executeAddEffectDispel(actor, target, pTable)
end

return itemObject
