-----------------------------------
-- ID: 16884
-- Item: Narval
-- Additional effect: water damage vs undead
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemAdditionalEffect = function(actor, target, baseAttackDamage, item)
    if target:getEcosystem() ~= xi.ecosystem.UNDEAD then
        return 0, 0, 0
    end

    local dStat  = actor:getStat(xi.mod.MND) - target:getStat(xi.mod.MND)
    local power  = 13 + utils.clamp(dStat, 0, 60)
    local pTable =
    {
        chance         = 10 + utils.clamp(dStat * 0.741, 1, 40), -- Averaged over the whole range, 10 + 0-40% with dMND
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
