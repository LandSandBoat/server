-----------------------------------
-- ID: 13685
-- Item: Invisible Mantle
-- Item Effect: gives invisible
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return 0
end

item_object.onItemUse = function(target)
    if (target:hasStatusEffect(xi.effect.INVISIBLE)) then
        target:messageBasic(xi.msg.basic.NO_EFFECT)
    else
        target:addStatusEffect(xi.effect.INVISIBLE, 0, 10, math.floor(180 * xi.settings.SNEAK_INVIS_DURATION_MULTIPLIER))
    end
end

return item_object
