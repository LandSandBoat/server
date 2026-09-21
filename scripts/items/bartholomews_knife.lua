-----------------------------------
-- ID: 17623
-- Item: Bartholomew's Knife
-- Additional effect: water damage
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemAdditionalEffect = function(actor, target, baseAttackDamage, item)
    local dStat  = actor:getStat(xi.mod.INT) - target:getStat(xi.mod.INT)
    local pTable =
    {
        chance         = 10,
        basePower      = math.max(0, math.randomInt(dStat, dStat + 5)), -- Unlimited scaling?
        attackType     = xi.attackType.MAGICAL,
        magicalElement = xi.element.WATER,
        canMAB         = false,
        canResist      = true,
        lowestResist   = 0.5,
    }

    return xi.combat.action.executeAddEffectDamage(actor, target, pTable)
end

return itemObject
