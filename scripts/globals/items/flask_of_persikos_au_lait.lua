-----------------------------------
-- ID: 4301
-- Item: Persikos au Lait
-- Item Effect: Restores 800 HP over 600 seconds
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return 0
end

item_object.onItemUse = function(target)
    if (not target:hasStatusEffect(xi.effect.REGEN)) then
        target:addStatusEffect(xi.effect.REGEN, 4, 3, 600)
    else
        target:messageBasic(xi.msg.basic.NO_EFFECT)
    end
end

return item_object
