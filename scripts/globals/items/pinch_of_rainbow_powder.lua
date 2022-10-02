-----------------------------------
-- ID: 5362
-- Rainbow Powder
-- When applied, it makes things invisible.
-- Removed Medicated status as per https://www.bg-wiki.com/ffxi/Rainbow_Powder
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return 0
end

item_object.onItemUse = function(target)
    if target:hasStatusEffect(xi.effect.INVISIBLE) then
       target:delStatusEffect(xi.effect.INVISIBLE)
    end

    target:addStatusEffect(xi.effect.INVISIBLE, 1, 10, math.floor(600 * xi.settings.main.SNEAK_INVIS_DURATION_MULTIPLIER))
end

return item_object
