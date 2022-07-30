-----------------------------------
-- Revert EXP rings to Era values.
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local m = Module:new("exp_rings")

m:addOverride("xi.globals.items.chariot_band.onItemUse", function(target)
  target:addStatusEffect(xi.effect.DEDICATION, 75, 0, 43200, 0, 500)
end)

m:addOverride("xi.globals.items.empress_band.onItemUse", function(target)
  target:addStatusEffect(xi.effect.DEDICATION, 50, 0, 43200, 0, 1000)
end)

m:addOverride("xi.globals.items.emperor_band.onItemUse", function(target)
  target:addStatusEffect(xi.effect.DEDICATION, 50, 0, 43200, 0, 2000)
end)

return m