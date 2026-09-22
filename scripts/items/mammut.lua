-----------------------------------
-- ID: 18503
-- Item: Mammut
-- Additional effect: ice damage
-----------------------------------
---@type TItem
local itemObject = {}

-- Made up stats, taken from old sql.
itemObject.onItemAdditionalEffect = function(actor, target, baseAttackDamage, item)
    local pTable =
    {
        chance         = 10,
        basePower      = 15,
        attackType     = xi.attackType.MAGICAL,
        magicalElement = xi.element.ICE,
        canMAB         = false,
        canResist      = true,
    }

    return xi.combat.action.executeAddEffectDamage(actor, target, pTable)
end

return itemObject
