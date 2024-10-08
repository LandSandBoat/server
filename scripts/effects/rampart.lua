-----------------------------------
-- xi.effect.RAMPART
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local power = effect:getPower()

    -- Regular effect
    effect:addMod(xi.mod.SLASH_SDT, power)
    effect:addMod(xi.mod.PIERCE_SDT, power)
    effect:addMod(xi.mod.IMPACT_SDT, power)
    effect:addMod(xi.mod.HTH_SDT, power)
    effect:addMod(xi.mod.FIRE_SDT, power)
    effect:addMod(xi.mod.ICE_SDT, power)
    effect:addMod(xi.mod.WIND_SDT, power)
    effect:addMod(xi.mod.EARTH_SDT, power)
    effect:addMod(xi.mod.THUNDER_SDT, power)
    effect:addMod(xi.mod.WATER_SDT, power)
    effect:addMod(xi.mod.LIGHT_SDT, power)
    effect:addMod(xi.mod.DARK_SDT, power)

    -- Iron will trait and augment. TODO: Why player only?
    if target:isPC() and target:hasTrait(xi.trait.IRON_WILL) then
        effect:addMod(xi.mod.SPELLINTERRUPT, target:getMerit(xi.merit.IRON_WILL))

        if target:getMod(xi.mod.ENHANCES_IRON_WILL) > 0 then
            local subPower = target:getMod(xi.mod.ENHANCES_IRON_WILL) * target:getMerit(xi.merit.IRON_WILL) / 19

            effect:addMod(xi.mod.FASTCAST, subPower)
            effect:setSubPower(subPower)
        end
    end
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
