-----------------------------------
--
-- tpz.effect.MARK_OF_SEED
--
--  DO NOT try to use this anywhere else but Fei'Yin!
-----------------------------------
local ID = require("scripts/zones/FeiYin/IDs")
require("scripts/globals/keyitems")
-----------------------------------

function onEffectGain(target, effect)
    target:setCharVar("SEED_AFTERGLOW_TIMER", 1)
end

function onEffectTick(target, effect)
    local Half_Minutes = target:getCharVar("SEED_AFTERGLOW_TIMER")
    if (Half_Minutes == 1) then
        target:setCharVar("SEED_AFTERGLOW_TIMER", (Half_Minutes+1))
        target:messageSpecial(ID.text.MARK_OF_SEED_FLICKERS)
    elseif (Half_Minutes == 40) then
        target:messageSpecial(ID.text.MARK_OF_SEED_IS_ABOUT_TO_DISSIPATE)
        target:setCharVar("SEED_AFTERGLOW_TIMER", (Half_Minutes+1))
    elseif (Half_Minutes == 20) then
        target:messageSpecial(ID.text.MARK_OF_SEED_GROWS_FAINTER)
        target:setCharVar("SEED_AFTERGLOW_TIMER", (Half_Minutes+1))
    elseif (Half_Minutes >= 2) then
        target:setCharVar("SEED_AFTERGLOW_TIMER", (Half_Minutes+1))
    end
end

function onEffectLose(target, effect)
    if (target:hasKeyItem(tpz.ki.MARK_OF_SEED) == false and player:hasKeyItem(tpz.ki.AZURE_KEY) == false) then
        target:messageSpecial(ID.text.MARK_OF_SEED_HAS_VANISHED)
    end
    target:setCharVar("SEED_AFTERGLOW_TIMER", 0)
    target:setCharVar("SEED_AFTERGLOW_MASK", 0)
    target:setCharVar("SEED_AFTERGLOW_INTENSITY", 0)
end
