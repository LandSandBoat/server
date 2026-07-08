-----------------------------------
-- ID: 17651
-- Item: Dainslaif
-- Additional effect: en-drain
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemAdditionalEffect = function(attacker, defender, baseAttackDamage, item)
    local dINT  = attacker:getStat(xi.mod.INT) - defender:getStat(xi.mod.INT)
    local power = 0

    if dINT > 15 then
        power = math.min(math.floor(56 + (dINT - 16) * 0.5), 72)
    else
        power = math.max(math.floor(40 + dINT), 37) -- Lower end of 37 is guessed, following Bloody Bolt pattern
    end

    local pTable =
    {
        chance          = 22, -- Observed rate is 21% which is close to (0.22 * .95) = 21%~ (resist roll failure)
        basePower       = power,
        attackType      = xi.attackType.PHYSICAL,
        physicalElement = xi.damageType.SLASHING,
        magicalElement  = xi.element.DARK,
        canResist       = true,
        lowestResist    = 0.5,
        limitUndead     = true,
        drainHP         = true,
        overDrain       = true,
        animation       = xi.subEffect.DARKNESS_DAMAGE,
    }

    return xi.combat.action.executeAddEffectDamage(attacker, defender, pTable)
end

return itemObject
