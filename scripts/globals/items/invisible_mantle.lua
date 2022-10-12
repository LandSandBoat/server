-----------------------------------
-- ID: 13685
-- Item: Invisible Mantle
-- Item Effect: gives invisible
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local effect = target:getStatusEffect(xi.effect.INVISIBLE)
    if effect ~= nil and effect:getSubType() == 13685 then
        target:delStatusEffect(xi.effect.INVISIBLE)
    end
    return 0
end

item_object.onItemUse = function(target)
    if (target:hasStatusEffect(xi.effect.INVISIBLE)) then
        target:messageBasic(xi.msg.basic.NO_EFFECT)
    else
        target:addStatusEffect(xi.effect.INVISIBLE, 0, 10, math.floor(180 * xi.settings.main.SNEAK_INVIS_DURATION_MULTIPLIER), 13685)
    end
end

return item_object
