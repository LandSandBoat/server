-----------------------------------
-- ID: 16515
-- Item: Colichemarde
-- Additional effect: darkness damage
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemAdditionalEffect = function(actor, target, baseAttackDamage, item)
    local dStat  = actor:getStat(xi.mod.INT) - target:getStat(xi.mod.INT)
    local power  = 4 + utils.clamp(dStat * 35 / 54, 0, 35) -- Linear interp
    local pTable =
    {
        chance         = 5,
        basePower      = math.randomInt(power, power + 7),
        attackType     = xi.attackType.MAGICAL,
        magicalElement = xi.element.DARK,
        canMAB         = false,
        canResist      = true,
    }

    return xi.combat.action.executeAddEffectDamage(actor, target, pTable)
end

return itemObject
