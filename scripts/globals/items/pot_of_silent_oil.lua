-----------------------------------
-- ID: 4165
-- Silent oil
-- This lubricant cuts down 99.99% of all friction
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return 0
end

item_object.onItemUse = function(target)
    if not target:hasStatusEffect(xi.effect.SNEAK) then
        target:addStatusEffect(xi.effect.SNEAK, 1, 10, math.floor(600 * xi.settings.main.SNEAK_INVIS_DURATION_MULTIPLIER))
    end
end

return item_object
