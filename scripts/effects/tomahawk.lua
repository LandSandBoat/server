-----------------------------------
-- xi.effect.TOMAHAWK
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local physSDT = { xi.mod.SLASH_SDT, xi.mod.PIERCE_SDT, xi.mod.IMPACT_SDT, xi.mod.HTH_SDT }

    for i = 1, #physSDT do
        local sdtModPhys    = target:getMod(physSDT[i])
        local reductionPhys = (1000 - sdtModPhys) * 0.25

        effect:addMod(physSDT[i], reductionPhys)
    end

    for element = xi.element.FIRE, xi.element.DARK do
        local elementSDTMod  = xi.combat.element.getElementalSDTModifier(element)
        local sdtModMagic    = target:getMod(elementSDTMod)
        local reductionMagic = sdtModMagic * 0.25

        effect:addMod(elementSDTMod, -reductionMagic)
    end
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
