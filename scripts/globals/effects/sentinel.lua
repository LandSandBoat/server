-----------------------------------
-- xi.effect.SENTINEL
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.UDMGPHYS, -effect:getPower())
    target:addMod(xi.mod.ENMITY, 100)
    target:addMod(xi.mod.ENMITY_LOSS_REDUCTION, effect:getSubPower())
end

effect_object.onEffectTick = function(target, effect)
   local power = effect:getPower()
   local decayby = 0
   -- Damage reduction decays until 50% then stops
   if (power > 50) then
      -- final tick with feet just has to be odd.
      if (power == 55) then
         decayby = 5
      -- decay by 8% per tick
      else
         decayby = 8
      end
      effect:setPower(power-decayby)
      target:delMod(xi.mod.UDMGPHYS, -decayby)
   end
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.UDMGPHYS, -effect:getPower())
    target:delMod(xi.mod.ENMITY, 100)
    target:delMod(xi.mod.ENMITY_LOSS_REDUCTION, effect:getSubPower())
end

return effect_object
