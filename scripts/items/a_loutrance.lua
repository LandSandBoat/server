-----------------------------------
-- ID: 18041
-- Item: A l'Outrance
-- Additional effect: darkness damage
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemAdditionalEffect = function(actor, target, baseAttackDamage, item)
    local ecosystem = target:isMob() and target:getEcosystem() or xi.ecosystem.UNCLASSIFIED

    if ecosystem ~= xi.ecosystem.BEAST then
        return 0, 0, 0
    end

    local dStat  = actor:getStat(xi.mod.INT) - target:getStat(xi.mod.INT)
    local power  = 11 + utils.clamp(math.floor(dStat * 0.6482), 0, 35) -- 0-35 over 54 dINT, linearly interpolated.
    local pTable =
    {
        chance         = 100,
        basePower      = math.randomInt(power, power + 5),
        attackType     = xi.attackType.MAGICAL,
        magicalElement = xi.element.DARK,
        canMAB         = false,
        canResist      = true,
    }

    return xi.combat.action.executeAddEffectDamage(actor, target, pTable)
end

return itemObject
