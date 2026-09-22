-----------------------------------
-- ID: 16434
-- Item: Sonic Knuckles
-- Additional effect: wind damage
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemAdditionalEffect = function(actor, target, baseAttackDamage, item)
    local pTable =
    {
        chance         = 5,
        basePower      = math.randomInt(6, 8),
        attackType     = xi.attackType.MAGICAL,
        magicalElement = xi.element.WIND,
        canMAB         = false,
        canResist      = true,
    }

    return xi.combat.action.executeAddEffectDamage(actor, target, pTable)
end

return itemObject
