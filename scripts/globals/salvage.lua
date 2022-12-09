-----------------------------------
-- Salvage Global Functions
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/zone")
-----------------------------------
xi = xi or {}
xi.salvage = xi.salvage or {}
-----------------------------------

xi.salvage.onCellItemCheck = function(target, effect, value)
    local statusEffect = target:getStatusEffect(effect)
    if statusEffect then
        local power = statusEffect:getPower()
        if bit.band(power, value) > 0 then
            return 0
        end
    end

    return 55
end

xi.salvage.onCellItemUse = function(target, effect, value, offset)
    local statusEffect = target:getStatusEffect(effect)
    local power = statusEffect:getPower()
    local newpower = bit.band(power, bit.bnot(value))
    local pet = target:getPet()

    target:delStatusEffectSilent(effect)
    if newpower > 0 then
        local duration = math.floor(statusEffect:getTimeRemaining() / 1000)
        target:addStatusEffectEx(effect, effect, newpower, 0, duration)
    end

    if
        pet ~= nil and
        (
            effect == xi.effect.DEBILITATION or
            effect == xi.effect.IMPAIRMENT or
            effect == xi.effect.OMERTA
        )
    then
        pet:delStatusEffectSilent(effect)
        if newpower > 0 then
            local duration = math.floor(statusEffect:getTimeRemaining() / 1000)
            pet:addStatusEffectEx(effect, effect, newpower, 0, duration)
        end
    end

    target:messageText(target, zones[target:getZoneID()].text.CELL_OFFSET + offset)
end
