-----------------------------------------
-- ID: 4512
-- Item: Vampire Juice
-- Item Effect: Restores 60 HP and MP over 90 seconds.
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return 0
end

item_object.onItemUse = function(target)
    local worked = false
    if (not target:hasStatusEffect(tpz.effect.REGEN)) then
        target:addStatusEffect(tpz.effect.REGEN, 2, 3, 90)
        worked = true
    end
    if (not target:hasStatusEffect(tpz.effect.REFRESH)) then
        target:addStatusEffect(tpz.effect.REFRESH, 2, 3, 90)
        worked = true
    end
    if (not worked) then
        target:messageBasic(tpz.msg.basic.NO_EFFECT)
    end
end

return item_object
