-----------------------------------
-- ID: 4164
-- Prism Powder
-- When applied, it makes things invisible.
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/status")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return 0
end

item_object.onItemUse = function(target)
    local duration = math.random(300, 480)
    if (target:hasStatusEffect(xi.effect.INVISIBLE)) then
        target:delStatusEffect(xi.effect.INVISIBLE)
    end
    target:addStatusEffect(xi.effect.INVISIBLE, 0, 10, math.floor(duration * xi.settings.SNEAK_INVIS_DURATION_MULTIPLIER))
end

return item_object
