-----------------------------------
-- ID: 17322
-- Item: Fire Arrow
-- Additional effect: Fire damage
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemAdditionalEffect = function(actor, target, baseAttackDamage, item)
    -- Unconfirmed power.
    local pTable =
    {
        ignoreEnSpell   = true,
        basePower       = math.random(7, 10),
        attackType      = xi.attackType.MAGICAL,
        magicalElement  = xi.element.FIRE,
        canResist       = true,
    }

    return xi.combat.action.executeAddEffectDamage(actor, target, pTable)
end

return itemObject
