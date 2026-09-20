-----------------------------------
-- ID: 18385
-- Item: Suzaku's Scythe
-- Additional effect: fire damage
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemAdditionalEffect = function(actor, target, baseAttackDamage, item)
    -- TODO: chance and damage is made up.
    local pTable =
    {
        chance         = 33,
        basePower      = 33,
        attackType     = xi.attackType.MAGICAL,
        magicalElement = xi.element.FIRE,
        canMAB         = false,
        canResist      = true,
        lowestResist   = 0.5,
    }

    return xi.combat.action.executeAddEffectDamage(actor, target, pTable)
end

return itemObject
