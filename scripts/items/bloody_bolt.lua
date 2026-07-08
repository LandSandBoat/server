-----------------------------------
-- ID: 18151
-- Item: Bloody Bolt
-- Additional effect: en-drain
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemAdditionalEffect = function(attacker, defender, baseAttackDamage, item)
    local dINT  = attacker:getStat(xi.mod.INT) - defender:getStat(xi.mod.INT)
    local power = 0

    if dINT > 15 then
        power = math.min(math.floor(76 + (dINT - 16) * 0.5), 92) -- 92 is the upper cap starting at 48 dINT
    else
        power = math.max(math.floor(60 + dINT), 57) -- minimum observed at more than -100 dINT is 57. Negative dINT does seem to drop you to 57, but scaling is currently unknown.
    end

    local pTable =
    {
        chance          = 100, -- Seems to always proc barring massive resistance
        basePower       = power,
        attackType      = xi.attackType.PHYSICAL,
        physicalElement = xi.damageType.PIERCING,
        magicalElement  = xi.element.DARK,
        canResist       = true,
        lowestResist    = 0.5,
        limitUndead     = true,
        drainHP         = true,
        overDrain       = true,
        animation       = xi.subEffect.HP_DRAIN,
    }

    return xi.combat.action.executeAddEffectDamage(attacker, defender, pTable)
end

return itemObject
