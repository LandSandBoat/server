-----------------------------------
-- ID: 18018
-- Item: Sirocco Kukri
-- Additional effect: Wind damage
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemAdditionalEffect = function(actor, target, baseAttackDamage, item)
    local pTable =
    {
        chance         = 100,
        basePower      = math.random(7, 10),
        attackType     = xi.attackType.MAGICAL,
        magicalElement = xi.element.WIND,
        canResist      = true,
    }

    return xi.combat.action.executeAddEffectDamage(actor, target, pTable)
end

return itemObject
