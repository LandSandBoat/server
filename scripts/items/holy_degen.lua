-----------------------------------
-- ID: 16523
-- Item: Holy Degen
-- Additional effect: light damage
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemAdditionalEffect = function(actor, target, baseAttackDamage, item)
    local dStat = actor:getStat(xi.mod.MND) - target:getStat(xi.mod.INT)
    local pTable =
    {
        chance         = utils.clamp(dStat * 4 / 9, 0, 24), -- Seems to be a linear scale over 54 dSTAT, 4 / 9 = 0.4444...
        basePower      = math.randomInt(3, 5),
        attackType     = xi.attackType.MAGICAL,
        magicalElement = xi.element.LIGHT,
        canMAB         = false,
        canResist      = true,
        lowestResist   = 0.5,
    }

    return xi.combat.action.executeAddEffectDamage(actor, target, pTable)
end

return itemObject
