-----------------------------------
-- xi.effect.GESTATION
-- https://ffxiclopedia.fandom.com/wiki/Gestation
--
-- Effects
-- Gestation is a combination of the following:
-- - Completely undetectable, even to True Sight and True Hearing monsters
-- - Quickening
-- - Unable take any actions (attacks, spells, job abilities, etc.)
--
-- Duration
-- - Outside Belligerency: 18 hours
-- - During Belligerency: 1 minute
--
-- How to remove the effect
-- - Wait for the effect to wear off
-- - Remove manually
-----------------------------------
---@type TEffect
local effectObject = {}

-- Retail multiplies speed by 1.5, so a Wamouracampa goes 30 to 45 and a Tiger stays at the 80 cap.
local speedMultiplier = 5000

effectObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.MOVE_SPEED_FLEE, speedMultiplier)
end

-- Ticks every 10 s (src/map/monstrosity.cpp), so this warns once.
effectObject.onEffectTick = function(target, effect)
    if effect:getTimeRemaining() <= 10000 then
        target:messageBasic(xi.msg.basic.ABOUT_TO_WEAR_OFF, effect:getEffectType())
    end
end

return effectObject
