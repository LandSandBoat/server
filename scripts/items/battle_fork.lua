-----------------------------------
-- ID: 16888
-- Item: Battle Fork
-- Additional effect: lightning damage
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemAdditionalEffect = function(actor, target, baseAttackDamage, item)
    local dStat  = actor:getStat(xi.mod.INT) - target:getStat(xi.mod.INT)
    local pTable =
    {
        chance         = 15 + utils.clamp(dStat / 3, 0, 18), -- 15 + 0-18% over 54 dINT, approx.
        basePower      = math.randomInt(9, 12),
        attackType     = xi.attackType.MAGICAL,
        magicalElement = xi.element.THUNDER,
        canMAB         = false,
        canResist      = true,
        lowestResist   = 0.5,
    }

    return xi.combat.action.executeAddEffectDamage(actor, target, pTable)
end

return itemObject
