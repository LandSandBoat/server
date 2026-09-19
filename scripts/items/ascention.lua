-----------------------------------
-- ID: 18042
-- Item: Ascention
-- Additional effect: fire damage
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemAdditionalEffect = function(actor, target, baseAttackDamage, item)
    if target:getEcosystem() ~= xi.ecosystem.UNDEAD then
        return 0, 0, 0
    end

    local dStat  = actor:getStat(xi.mod.MND) - target:getStat(xi.mod.INT) -- Is this MND vs MND?
    local power  = 10 + utils.clamp(math.floor(dStat / 1.5), 0, 55) -- Somewhat approximate. It looks like x/256 madness is going on
    local pTable =
    {
        chance          = 100,
        basePower       = math.randomInt(power, power + 5), -- Upper range is sometimes not +5, but this is good enough.
        attackType      = xi.attackType.MAGICAL,
        magicalElement  = xi.element.FIRE,
        canMAB          = false,
        canResist       = true,
        lowestResist    = 0.5,
    }

    return xi.combat.action.executeAddEffectDamage(actor, target, pTable)
end

return itemObject
