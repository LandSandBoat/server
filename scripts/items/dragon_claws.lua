-----------------------------------
-- ID: 16416
-- Item: Dragon Claws
-- Additional effect: fire damage
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemAdditionalEffect = function(actor, target, baseAttackDamage, item)
    local dStat  = actor:getStat(xi.mod.INT) - target:getStat(xi.mod.INT)
    local power  = 6 + utils.clamp(math.floor(dStat / 1.5), 0, 32) -- Somewhat approximate. It looks like x/256 madness is going on
    local pTable =
    {
        chance          = 5,
        basePower       = math.randomInt(power, power + 3), -- Upper range is sometimes not +5, but this is good enough.
        attackType      = xi.attackType.MAGICAL,
        magicalElement  = xi.element.FIRE,
        canMAB          = false,
        canResist       = true,
        lowestResist    = 0.5,
    }

    return xi.combat.action.executeAddEffectDamage(actor, target, pTable)
end

return itemObject
