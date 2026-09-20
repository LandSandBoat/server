-----------------------------------
-- ID: 17485
-- Item: Dragon Claws +1
-- Additional effect: fire damage
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemAdditionalEffect = function(actor, target, baseAttackDamage, item)
    local dStat  = actor:getStat(xi.mod.INT) - target:getStat(xi.mod.INT)
    local power  = 9 + utils.clamp(math.floor(dStat / 1.5), 0, 32)
    local pTable =
    {
        chance         = 5,
        basePower      = math.randomInt(power, power + 3),
        attackType     = xi.attackType.MAGICAL,
        magicalElement = xi.element.FIRE,
        canMAB         = false,
        canResist      = true,
        lowestResist   = 0.5,
    }

    return xi.combat.action.executeAddEffectDamage(actor, target, pTable)
end

return itemObject
