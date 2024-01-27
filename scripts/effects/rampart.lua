-----------------------------------
-- xi.effect.RAMPART
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local power = effect:getPower()

    if target:isPC() and target:hasTrait(77) then -- Iron Will
        target:addMod(xi.mod.SPELLINTERRUPT, target:getMerit(xi.merit.IRON_WILL))
    end

    if target:getMod(xi.mod.ENHANCES_IRON_WILL) > 0 then
        local subPower = target:getMod(xi.mod.ENHANCES_IRON_WILL) * (target:getMerit(xi.merit.IRON_WILL) / 19)

        target:addMod(xi.mod.FASTCAST, subPower)
        effect:setSubPower(subPower)
    end

    target:addMod(xi.mod.SLASH_SDT, power)
    target:addMod(xi.mod.PIERCE_SDT, power)
    target:addMod(xi.mod.IMPACT_SDT, power)
    target:addMod(xi.mod.HTH_SDT, power)
    target:addMod(xi.mod.FIRE_SDT, power)
    target:addMod(xi.mod.ICE_SDT, power)
    target:addMod(xi.mod.WIND_SDT, power)
    target:addMod(xi.mod.EARTH_SDT, power)
    target:addMod(xi.mod.THUNDER_SDT, power)
    target:addMod(xi.mod.WATER_SDT, power)
    target:addMod(xi.mod.LIGHT_SDT, power)
    target:addMod(xi.mod.DARK_SDT, power)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    local power    = effect:getPower()
    local subPower = effect:getSubPower()

    if target:isPC() and target:hasTrait(77) then -- Iron Will
        target:delMod(xi.mod.SPELLINTERRUPT, target:getMerit(xi.merit.IRON_WILL))
    end

    if subPower > 0 then
        target:delMod(xi.mod.FASTCAST, subPower)
    end

    target:delMod(xi.mod.SLASH_SDT, power)
    target:delMod(xi.mod.PIERCE_SDT, power)
    target:delMod(xi.mod.IMPACT_SDT, power)
    target:delMod(xi.mod.HTH_SDT, power)
    target:delMod(xi.mod.FIRE_SDT, power)
    target:delMod(xi.mod.ICE_SDT, power)
    target:delMod(xi.mod.WIND_SDT, power)
    target:delMod(xi.mod.EARTH_SDT, power)
    target:delMod(xi.mod.THUNDER_SDT, power)
    target:delMod(xi.mod.WATER_SDT, power)
    target:delMod(xi.mod.LIGHT_SDT, power)
    target:delMod(xi.mod.DARK_SDT, power)
end

return effectObject
