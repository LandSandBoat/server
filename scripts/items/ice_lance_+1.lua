-----------------------------------
-- ID: 16895
-- Item: Ice Lance +1
-- Additional effect: ice damage
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemAdditionalEffect = function(actor, target, baseAttackDamage, item)
    local dStat  = actor:getStat(xi.mod.INT) - target:getStat(xi.mod.INT)
    local pTable =
    {
        chance         = 8 + utils.clamp(dStat * 7 / 54, 0, 7), -- 7% over dINT54
        basePower      = math.randomInt(15, 20),
        attackType     = xi.attackType.MAGICAL,
        magicalElement = xi.element.ICE,
        canMAB         = false,
        canResist      = true,
    }

    return xi.combat.action.executeAddEffectDamage(actor, target, pTable)
end

return itemObject
