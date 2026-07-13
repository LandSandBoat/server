-----------------------------------
-- ID: 18700
-- Item: Wind Arrow
-- Additional effect: Wind damage
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemAdditionalEffect = function(actor, target, baseAttackDamage, item)
    local dStat = actor:getStat(xi.mod.INT) - target:getStat(xi.mod.INT)
    -- Unconfirmed power.

    local pTable =
    {
        ignoreEnSpell   = true,
        basePower       = 10 + utils.clamp(dStat, -3, 8) + utils.clamp(math.floor((dStat - 8) / 2), 0, 8),
        attackType      = xi.attackType.MAGICAL,
        magicalElement  = xi.element.WIND,
        canResist       = true,
    }

    return xi.combat.action.executeAddEffectDamage(actor, target, pTable)
end

return itemObject
