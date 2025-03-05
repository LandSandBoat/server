-----------------------------------
-- ID: 5262
-- Hysteroanima
-- Replaces non-working xi.effect.HYSTERIA with working xi.effect.AMNESIA
-----------------------------------
require("modules/module_utils")
--------------------------------------------
local m = Module:new("item_hysteroanima_fix")

m:addOverride("xi.items.bottle_of_hysteroanima.onItemUse", function(target)
    target:delStatusEffectSilent(xi.effect.AMNESIA)
    target:addStatusEffectEx(xi.effect.AMNESIA, xi.effect.AMNESIA, 1, 0, math.random(25, 32), 0, 0, 0, xi.effectFlag.NO_LOSS_MESSAGE)
end)

return m