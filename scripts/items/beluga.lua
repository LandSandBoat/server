-----------------------------------
-- ID: 18953
-- Item: Beluga
-- Additional effect: water damage
-----------------------------------
---@type TItem
local itemObject = {}

-- Old made up stuff from sql, fix when researched
itemObject.onItemAdditionalEffect = function(actor, target, baseAttackDamage, item)
    local pTable =
    {
        chance         = 10,
        basePower      = math.randomInt(20, 25),
        attackType     = xi.attackType.MAGICAL,
        magicalElement = xi.element.WATER,
        canMAB         = false,
        canResist      = true,
        lowestResist   = 0.5,
    }

    return xi.combat.action.executeAddEffectDamage(actor, target, pTable)
end

return itemObject
