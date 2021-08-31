-----------------------------------
-- xi.effect.WARCRY
-- Notes:
-- Savagery TP bonus not cut in half like ffxclopedia says.
-- ffxiclopedia is wrong, bg wiki right. See link where testing was done.
-- http://www.bluegartr.com/threads/108199-Random-Facts-Thread-Other?p=5367464&viewfull=1#post5367464
-----------------------------------
require("scripts/globals/jobpoints")
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    local jpLevel = target:getJobPointLevel(xi.jp.WARCRY_EFFECT)
    local jpEffect = jpLevel * 3

    target:addMod(xi.mod.ATTP, effect:getPower())
    target:addMod(xi.mod.TP_BONUS, effect:getSubPower())

    -- Job Point Bonus
    target:addMod(xi.mod.ATT, jpEffect)
    target:addMod(xi.mod.RATT, jpEffect)
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    local jpLevel = target:getJobPointLevel(xi.jp.WARCRY_EFFECT)
    local jpEffect = jpLevel * 3

    target:delMod(xi.mod.ATTP, effect:getPower())
    target:delMod(xi.mod.TP_BONUS, effect:getSubPower())

    -- Job Point Bonus
    target:delMod(xi.mod.ATT, jpEffect)
    target:delMod(xi.mod.RATT, jpEffect)
end

return effect_object
