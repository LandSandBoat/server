-----------------------------------
-- ID: 17323
-- Item: Ice Arrow
-- Additional effect: Ice damage
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
        magicalElement  = xi.element.ICE,
        canResist       = true,
    }

    return xi.combat.action.executeAddEffectDamage(actor, target, pTable)
end

return itemObject
