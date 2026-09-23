-----------------------------------
-- ID: 17750
-- Item: Anthos Xiphos
-- Additional effect: water damage
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemAdditionalEffect = function(actor, target, baseAttackDamage, item)
    local dStat  = actor:getStat(xi.mod.INT) - target:getStat(xi.mod.INT)
    local pTable =
    {
        chance         = 10 + utils.clamp(dStat * 0.0926, 0, 25), -- 0-5% over 54 dINT, approx.
        basePower      = math.randomInt(6, 8),
        attackType     = xi.attackType.MAGICAL,
        magicalElement = xi.element.WATER,
        canMAB         = false,
        canResist      = true,
        lowestResist   = 0.5,
    }

    return xi.combat.action.executeAddEffectDamage(actor, target, pTable)
end

return itemObject
