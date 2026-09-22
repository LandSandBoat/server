-----------------------------------
-- ID: 16542
-- Item: Wing Sword
-- Additional effect: wind damage
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemAdditionalEffect = function(actor, target, baseAttackDamage, item)
    local dStat  = actor:getStat(xi.mod.INT) - target:getStat(xi.mod.INT)
    local power  = 6 + utils.clamp(dStat * 35 / 54, 0, 35) -- Linear interp
    local pTable =
    {
        chance         = 5,
        basePower      = math.randomInt(power, power + 3),
        attackType     = xi.attackType.MAGICAL,
        magicalElement = xi.element.WIND,
        canMAB         = false,
        canResist      = true,
    }

    return xi.combat.action.executeAddEffectDamage(actor, target, pTable)
end

return itemObject
