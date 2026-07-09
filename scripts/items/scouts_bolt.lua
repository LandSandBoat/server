-----------------------------------
-- ID: 22287
-- Item: Scouts Bolt
-- Additional effect: Light damage
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemAdditionalEffect = function(actor, target, baseAttackDamage, item)
    local dStat = actor:getStat(xi.mod.MND) - target:getStat(xi.mod.MND)
    -- Unconfirmed power.

    local pTable =
    {
        isRanged        = true,
        basePower       = 40 + utils.clamp(dStat, -3, 8) + utils.clamp(math.floor((dStat - 8) / 2), 0, 8),
        attackType      = xi.attackType.MAGICAL,
        magicalElement  = xi.element.LIGHT,
        canResist       = true,
    }

    return xi.combat.action.executeAddEffectDamage(actor, target, pTable)
end

return itemObject
