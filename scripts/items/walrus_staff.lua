-----------------------------------
-- ID: 17135
-- Item: Walrus Staff
-- Additional effect: ice damage
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemAdditionalEffect = function(actor, target, baseAttackDamage, item)
    local dStat  = actor:getStat(xi.mod.INT) - target:getStat(xi.mod.INT)
    local pTable =
    {
        chance         = 8 + utils.clamp(dStat * 3 / 27, 0, 25), -- 0-8% over 54 dINT, approx.
        basePower      = math.randomInt(12, 16),
        attackType     = xi.attackType.MAGICAL,
        magicalElement = xi.element.ICE,
        canMAB         = false,
        canResist      = true,
    }

    return xi.combat.action.executeAddEffectDamage(actor, target, pTable)
end

return itemObject
