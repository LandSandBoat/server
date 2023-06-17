-----------------------------------
-- xi.effect.MARK_OF_SEED
-- DO NOT try to use this anywhere else but Fei'Yin!
-----------------------------------
local ID = require("scripts/zones/FeiYin/IDs")
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:setCharVar("SEED_AFTERGLOW_TIMER", 1)
end

effectObject.onEffectTick = function(target, effect)
    local halfMinutes = target:getCharVar("SEED_AFTERGLOW_TIMER")

    if halfMinutes == 1 then
        target:setCharVar("SEED_AFTERGLOW_TIMER", halfMinutes + 1)
        target:messageSpecial(ID.text.MARK_OF_SEED_FLICKERS)
    elseif halfMinutes == 40 then
        target:messageSpecial(ID.text.MARK_OF_SEED_IS_ABOUT_TO_DISSIPATE)
        target:setCharVar("SEED_AFTERGLOW_TIMER", halfMinutes + 1)
    elseif halfMinutes == 20 then
        target:messageSpecial(ID.text.MARK_OF_SEED_GROWS_FAINTER)
        target:setCharVar("SEED_AFTERGLOW_TIMER", halfMinutes + 1)
    elseif halfMinutes >= 2 then
        target:setCharVar("SEED_AFTERGLOW_TIMER", halfMinutes + 1)
    end
end

effectObject.onEffectLose = function(target, effect)
    if
        not target:hasKeyItem(xi.ki.MARK_OF_SEED) and
        not target:hasKeyItem(xi.ki.AZURE_KEY)
    then
        target:messageSpecial(ID.text.MARK_OF_SEED_HAS_VANISHED)
    end

    target:setCharVar("SEED_AFTERGLOW_TIMER", 0)
    target:setCharVar("SEED_AFTERGLOW_MASK", 0)
    target:setCharVar("SEED_AFTERGLOW_INTENSITY", 0)
end

return effectObject
