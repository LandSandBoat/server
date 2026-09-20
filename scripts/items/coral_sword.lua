-----------------------------------
-- ID: 16548
-- Item: Coral Sword
-- Additional effect: water damage
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemAdditionalEffect = function(actor, target, baseAttackDamage, item)
    local dStat  = actor:getStat(xi.mod.INT) - target:getStat(xi.mod.INT)
    local power  = utils.clamp(dStat / 2, 0, 54) -- Kinda jank looking, but it sort of aligns. Need more data.
    local pTable =
    {
        chance         = 5 + utils.clamp(dStat * 0.186, 0, 10), -- 0-10% over 54 dINT, approx.
        basePower      = math.randomInt(power + 6, power + 9),
        attackType     = xi.attackType.MAGICAL,
        magicalElement = xi.element.WATER,
        canMAB         = false,
        canResist      = true,
        lowestResist   = 0.5,
    }

    return xi.combat.action.executeAddEffectDamage(actor, target, pTable)
end

return itemObject
