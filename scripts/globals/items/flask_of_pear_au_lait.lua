-----------------------------------
-- ID: 4301
-- Item: Pear au Lait
-- Item Effect: Restores 300 HP over 300 seconds
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return 0
end

item_object.onItemUse = function(target)
    if (not target:hasStatusEffect(tpz.effect.REGEN)) then
        target:addStatusEffect(tpz.effect.REGEN, 3, 3, 300)
    else
        target:messageBasic(tpz.msg.basic.NO_EFFECT)
    end
end

return item_object
