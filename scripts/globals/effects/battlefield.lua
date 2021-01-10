-----------------------------------
-- tpz.effect.BATTLEFIELD
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

function onEffectGain(target, effect)
    if target:getPet() then
        target:getPet():addStatusEffect(effect)
    end

    if target:getObjType() == tpz.objType.PC then
        target:clearTrusts()
    end
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    local pet = target:getPet()
    if pet then
        pet:delStatusEffect(tpz.effect.BATTLEFIELD)
        pet:leaveBattlefield(1)
    end
    target:setLocalVar("[battlefield]area", 0)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end

return effect_object
