-----------------------------------
-- xi.effect.DEBILITATION
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

local stats_bits =
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

effect_object.onEffectGain = function(target, effect)
    local power = effect:getPower()
    for statbit, mod in ipairs(stats_bits) do
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

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    local power = effect:getPower()
    for statbit, mod in ipairs(stats_bits) do
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

return effect_object
