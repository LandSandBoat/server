-----------------------------------
-- ID: 14491
-- Item: Dominus Shield
-- Item Effect: Restores 20-35 MP
-----------------------------------
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return 0
end

item_object.onItemUse = function(target)
    local mpHeal = math.random(60, 85)
    local dif = target:getMaxMP() - target:getMP()
    if (mpHeal > dif) then
        mpHeal = dif
    end
    target:addMP(mpHeal)
    target:messageBasic(xi.msg.basic.RECOVERS_MP, 0, mpHeal)
end

return item_object
