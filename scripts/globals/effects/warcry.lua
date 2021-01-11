-----------------------------------
-- tpz.effect.WARCRY
-- Notes:
-- Savagery TP bonus not cut in half like ffxclopedia says.
-- ffxiclopedia is wrong, bg wiki right. See link where testing was done.
-- http://www.bluegartr.com/threads/108199-Random-Facts-Thread-Other?p=5367464&viewfull=1#post5367464
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.ATTP, effect:getPower())
    target:addMod(tpz.mod.TP_BONUS, effect:getSubPower())
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.ATTP, effect:getPower())
    target:delMod(tpz.mod.TP_BONUS, effect:getSubPower())
end

return effect_object
