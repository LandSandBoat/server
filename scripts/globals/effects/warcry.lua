-----------------------------------
--
--     tpz.effect.WARCRY
--
-- Notes:
-- Savagery TP bonus not cut in half like ffxclopedia says.
-- ffxiclopedia is wrong, bg wiki right. See link where testing was done.
-- http://www.bluegartr.com/threads/108199-Random-Facts-Thread-Other?p=5367464&viewfull=1#post5367464
-----------------------------------

require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target, effect)
    target:addMod(tpz.mod.ATTP, effect:getPower())
    target:addMod(tpz.mod.TP_BONUS, effect:getSubPower())
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.ATTP, effect:getPower())
    target:delMod(tpz.mod.TP_BONUS, effect:getSubPower())
end
