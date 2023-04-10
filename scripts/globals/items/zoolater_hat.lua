-----------------------------------
-- ID: 15182
-- Item: Zoolater Hat
-- Item Effect: Pet gets meditate
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return 0
end

itemObject.onItemUse = function(target)
    local pet = target:getPet()
    if pet then
        pet:addStatusEffect(xi.effect.REGAIN, 15, 3, 15)
    else
        target:messageBasic(xi.msg.basic.NO_EFFECT)
    end
end

return itemObject
