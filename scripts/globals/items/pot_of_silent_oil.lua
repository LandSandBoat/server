-----------------------------------------
-- ID: 4165
-- Silent oil
-- This lubricant cuts down 99.99% of all friction
-----------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return 0
end

item_object.onItemUse = function(target)
    local duration = math.random(60, 180)
    if (not target:hasStatusEffect(tpz.effect.SNEAK)) then
        target:addStatusEffect(tpz.effect.SNEAK, 1, 10, math.floor(duration * SNEAK_INVIS_DURATION_MULTIPLIER))
    end
end

return item_object
