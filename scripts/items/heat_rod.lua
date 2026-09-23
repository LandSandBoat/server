-----------------------------------
-- ID: 17071
-- Item: Heat Rod
-- Additional effect: lightning damage
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemAdditionalEffect = function(actor, target, baseAttackDamage, item)
    local dStat  = actor:getStat(xi.mod.INT) - target:getStat(xi.mod.INT)
    local pTable =
    {
        chance         = utils.clamp(dStat * 0.463, 0, 25), -- 0-25% over 54 dINT, approx.
        basePower      = math.randomInt(6, 8),
        attackType     = xi.attackType.MAGICAL,
        magicalElement = xi.element.THUNDER,
        canMAB         = false,
        canResist      = true,
        lowestResist   = 0.5,
    }

    return xi.combat.action.executeAddEffectDamage(actor, target, pTable)
end

return itemObject
