-----------------------------------
-- xi.effect.TOMAHAWK
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local physSDT = { xi.mod.SLASH_SDT, xi.mod.PIERCE_SDT, xi.mod.IMPACT_SDT, xi.mod.HTH_SDT }

    for i = 1, #physSDT do
        local physicalSDTModifier   = physSDT[i]
        local physicalSDTValue      = target:getMod(physicalSDTModifier)
        local physicalSDTAdjustment = math.floor(physicalSDTValue * 0.25)

        effect:addMod(physicalSDTModifier, -physicalSDTAdjustment)
    end

    for element = xi.element.FIRE, xi.element.DARK do
        local elementSDTModifier   = xi.combat.element.getElementalSDTModifier(element)
        local elementSDTValue      = target:getMod(elementSDTModifier)
        local elementSDTAdjustment = math.floor(elementSDTValue * 0.25)

        effect:addMod(elementSDTModifier, -elementSDTAdjustment)
    end
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
