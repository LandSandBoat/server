-----------------------------------
-- ID: 16929
-- Item: Burning Claymore
-- Additional effect: fire damage
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemAdditionalEffect = function(actor, target, baseAttackDamage, item)
    local pTable =
    {
        chance         = 9,
        basePower      = math.randomInt(6, 8),
        attackType     = xi.attackType.MAGICAL,
        magicalElement = xi.element.FIRE,
        canMAB         = false,
        canResist      = true,
        lowestResist   = 0.5,
    }

    return xi.combat.action.executeAddEffectDamage(actor, target, pTable)
end

return itemObject
