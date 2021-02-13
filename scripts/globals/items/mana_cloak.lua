-----------------------------------
-- ID: 14491
-- Item: Mana Cloak
-- Item Effect: Restores 20-35 MP
-----------------------------------
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    if (target:getMP() == target:getMaxMP()) then
        return tpz.msg.basic.ITEM_UNABLE_TO_USE
    end
    return 0
end

item_object.onItemUse = function(target)
    local mpHeal = math.random(20, 35)
    local dif = target:getMaxMP() - target:getMP()
    if (mpHeal > dif) then
        mpHeal = dif
    end
    target:addMP(mpHeal)
    target:messageBasic(tpz.msg.basic.RECOVERS_MP, 0, mpHeal)
end

return item_object
