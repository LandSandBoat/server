-----------------------------------
-- ID: 17324
-- Item: Lightning Arrow
-- Additional effect: Lightning damage
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemAdditionalEffect = function(actor, target, baseAttackDamage, item)
    -- Unconfirmed power.
    local pTable =
    {
        isRanged        = true,
        basePower       = math.random(7, 10),
        attackType      = xi.attackType.MAGICAL,
        magicalElement  = xi.element.THUNDER,
        canResist       = true,
    }

    return xi.combat.action.executeAddEffectDamage(actor, target, pTable)
end

return itemObject
