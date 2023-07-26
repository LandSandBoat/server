-----------------------------------
-- xi.effect.DEBILITATION
-----------------------------------
local effectObject = {}

local statsBits =
{
    xi.mod.STR,
    xi.mod.DEX,
    xi.mod.VIT,
    xi.mod.AGI,
    xi.mod.INT,
    xi.mod.MND,
    xi.mod.CHR,
    xi.mod.HPP,
    xi.mod.MPP
}

effectObject.onEffectGain = function(target, effect)
    local power = effect:getPower()
    for statbit, mod in ipairs(statsBits) do
        if bit.band(bit.lshift(1, statbit - 1), power) > 0 then
            if mod == xi.mod.HPP or mod == xi.mod.MPP then
                target:addMod(mod, -40)
            else
                target:addMod(mod, -30)
            end
        end
    end

    target:setStatDebilitation(power)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    local power = effect:getPower()
    for statbit, mod in ipairs(statsBits) do
        if bit.band(bit.lshift(1, statbit - 1), power) > 0 then
            if mod == xi.mod.HPP or mod == xi.mod.MPP then
                target:delMod(mod, -40)
            else
                target:delMod(mod, -30)
            end
        end
    end

    target:setStatDebilitation(0)
end

return effectObject
