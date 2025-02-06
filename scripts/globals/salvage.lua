-----------------------------------
-- Salvage Global Functions
-----------------------------------
xi = xi or {}
xi.salvage = xi.salvage or {}
-----------------------------------

xi.salvage.onCellItemCheck = function(target, effect, value)
    if target:getCurrentRegion() ~= xi.region.ALZADAAL then
        return xi.msg.basic.CANT_BE_USED_IN_AREA
    end

    local statusEffect = target:getStatusEffect(effect)
    if statusEffect then
        local power = statusEffect:getPower()
        if bit.band(power, value) > 0 then
            return 0
        end
    end

    return xi.msg.basic.ITEM_UNABLE_TO_USE
end

xi.salvage.onCellItemUse = function(target, effect, value, offset)
    local statusEffect = target:getStatusEffect(effect)
    local power = statusEffect:getPower()
    local newpower = bit.band(power, bit.bnot(value))
    local pet = target:getPet()
    local instance = target:getInstance()

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
    instance:setLocalVar('cellsUsed', instance:getLocalVar('cellsUsed') + 1)
end
