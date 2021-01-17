-----------------------------------------
-- ID: 15753
-- Item: Dream Boots +1
-- Enchantment: Sneak
-- Duration: 3 Mins 20 Secs
-- TODO: Enhances duration of Sneak Effect
-----------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return 0
end

item_object.onItemUse = function(target)
    if (not target:hasStatusEffect(tpz.effect.SNEAK)) then
        target:addStatusEffect(tpz.effect.SNEAK, 1, 10, math.floor(200 * SNEAK_INVIS_DURATION_MULTIPLIER))
    end
end

return item_object
