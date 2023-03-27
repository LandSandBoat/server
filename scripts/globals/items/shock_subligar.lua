-----------------------------------
-- ID: 15650
-- Item: shock subligar
-- Item Effect: Shock Spikes
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return 0
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.SHOCK_SPIKES, 15, 0, 180, 0, 0, 0, xi.items.SHOCK_SUBLIGAR)
end

return itemObject
