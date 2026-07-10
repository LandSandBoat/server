-----------------------------------
-- ID: 17327
-- Item: Grand Knights Arrow
-- Additional effect: Fire damage
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemAdditionalEffect = function(actor, target, baseAttackDamage, item)
    local dStat = actor:getStat(xi.mod.INT) - target:getStat(xi.mod.INT)
    -- Unconfirmed power.

    local pTable =
    {
        isRanged        = true,
        basePower       = 10 + utils.clamp(dStat, -3, 8) + utils.clamp(math.floor((dStat - 8) / 2), 0, 8),
        attackType      = xi.attackType.MAGICAL,
        magicalElement  = xi.element.FIRE,
        canResist       = true,
    }

    return xi.combat.action.executeAddEffectDamage(actor, target, pTable)
end

return itemObject
