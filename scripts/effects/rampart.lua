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

    for i = xi.mod.SLASH_SDT, xi.mod.DARK_SDT do
        target:addMod(i, power)
    end
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

    for i = xi.mod.SLASH_SDT, xi.mod.DARK_SDT do
        target:delMod(i, power)
    end
end

return effectObject
