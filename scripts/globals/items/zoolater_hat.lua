-----------------------------------
-- ID: 15182
-- Item: Zoolater Hat
-- Item Effect: Pet gets meditate
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return 0
end

item_object.onItemUse = function(target)
    local pet = target:getPet()
    if (pet) then
        pet:addStatusEffect(tpz.effect.REGAIN, 15, 3, 15)
    else
        target:messageBasic(tpz.msg.basic.NO_EFFECT)
    end
end

return item_object
