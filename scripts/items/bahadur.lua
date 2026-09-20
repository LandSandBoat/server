-----------------------------------
-- ID: 19151
-- Item: Bahadur
-- Additional effect: fire damage
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemAdditionalEffect = function(actor, target, baseAttackDamage, item)
    local pTable =
    {
        chance         = 7.5, -- TODO: looks like it might scale with INT?
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
