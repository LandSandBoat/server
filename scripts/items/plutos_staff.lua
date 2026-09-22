-----------------------------------
-- ID: 17560
-- Item: Pluto's Staff
-- Additional effect: darkness damage
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemAdditionalEffect = function(actor, target, baseAttackDamage, item)
    local pTable =
    {
        chance         = 25, -- guessed
        basePower      = math.randomInt(25, 34),
        attackType     = xi.attackType.MAGICAL,
        magicalElement = xi.element.DARK,
        canMAB         = false,
        canResist      = true,
    }

    return xi.combat.action.executeAddEffectDamage(actor, target, pTable)
end

return itemObject
