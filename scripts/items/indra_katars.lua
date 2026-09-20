-----------------------------------
-- ID: 17511
-- Item: Indra Katars
-- Additional effect: lightning damage
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemAdditionalEffect = function(actor, target, baseAttackDamage, item)
    local pTable =
    {
        chance         = 5,
        basePower      = math.randomInt(8, 10),
        attackType     = xi.attackType.MAGICAL,
        magicalElement = xi.element.THUNDER,
        canMAB         = false,
        canResist      = true,
        lowestResist   = 0.5,
    }

    return xi.combat.action.executeAddEffectDamage(actor, target, pTable)
end

return itemObject
