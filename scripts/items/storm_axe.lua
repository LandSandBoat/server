-----------------------------------
-- ID: 16675
-- Item: Storm Axe
-- Additional effect: wind damage
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemAdditionalEffect = function(actor, target, baseAttackDamage, item)
    local dStat  = actor:getStat(xi.mod.INT) - target:getStat(xi.mod.INT)
    local pTable =
    {
        chance         = 5 + utils.clamp(dStat * 10 / 54, 0, 10), -- 0-10% over 54 int
        basePower      = math.randomInt(9, 12),
        attackType     = xi.attackType.MAGICAL,
        magicalElement = xi.element.WIND,
        canMAB         = false,
        canResist      = true,
    }

    return xi.combat.action.executeAddEffectDamage(actor, target, pTable)
end

return itemObject
