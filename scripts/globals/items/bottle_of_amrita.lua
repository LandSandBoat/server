-----------------------------------
-- ID: 4513
-- Item: Amrita
-- Item Effect: Restores 500 HP and MP over 300 seconds.
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return 0
end

item_object.onItemUse = function(target)
    local worked = false
    if (not target:hasStatusEffect(xi.effect.REGEN)) then
        target:addStatusEffect(xi.effect.REGEN, 5, 3, 300)
        worked = true
    end
    if (not target:hasStatusEffect(xi.effect.REFRESH)) then
        target:addStatusEffect(xi.effect.REFRESH, 5, 3, 300)
        worked = true
    end
    if (not worked) then
        target:messageBasic(xi.msg.basic.NO_EFFECT)
    end
end

return item_object
