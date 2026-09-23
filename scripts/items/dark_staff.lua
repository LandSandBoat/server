-----------------------------------
-- ID: 17559
-- Item: Dark Staff
-- Additional effect: darkness damage
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemAdditionalEffect = function(actor, target, baseAttackDamage, item)
    local pTable =
    {
        chance         = 15, -- guessed
        basePower      = math.randomInt(12, 16),
        attackType     = xi.attackType.MAGICAL,
        magicalElement = xi.element.DARK,
        canMAB         = false,
        canResist      = true,
    }

    return xi.combat.action.executeAddEffectDamage(actor, target, pTable)
end

return itemObject
