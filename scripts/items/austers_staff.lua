-----------------------------------
-- ID: 17550
-- Item: Auster's Staff
-- Additional effect: wind damage
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemAdditionalEffect = function(actor, target, baseAttackDamage, item)
    local pTable =
    {
        chance         = 25, -- guessed
        basePower      = math.randomInt(25, 34),
        attackType     = xi.attackType.MAGICAL,
        magicalElement = xi.element.WIND,
        canMAB         = false,
        canResist      = true,
    }

    return xi.combat.action.executeAddEffectDamage(actor, target, pTable)
end

return itemObject
