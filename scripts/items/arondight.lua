-----------------------------------
-- ID: 16945
-- Item: Arondight
-- Additional effect: water damage
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemAdditionalEffect = function(actor, target, baseAttackDamage, item)
    local dStat  = actor:getStat(xi.mod.CHR) - target:getStat(xi.mod.CHR)
    local power  = 13 + utils.clamp(dStat, 0, 60)
    local pTable =
    {
        chance         = 1 + utils.clamp(dStat * 0.908, 1, 50), -- Averaged over the whole range
        basePower      = math.randomInt(power, power + 7),
        attackType     = xi.attackType.MAGICAL,
        magicalElement = xi.element.WATER,
        canMAB         = false,
        canResist      = true,
        lowestResist   = 0.5,
    }

    return xi.combat.action.executeAddEffectDamage(actor, target, pTable)
end

return itemObject
