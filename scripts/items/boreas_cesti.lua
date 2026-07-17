-----------------------------------
-- ID: 18359
-- Item: Boreas Cesti
-- Additional effect: Wind damage
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemAdditionalEffect = function(actor, target, baseAttackDamage, item)
    local pTable =
    {
        basePower       = math.random(5, 7),
        attackType      = xi.attackType.MAGICAL,
        magicalElement  = xi.element.WIND,
        canResist       = true,
    }

    return xi.combat.action.executeAddEffectDamage(actor, target, pTable)
end

return itemObject
