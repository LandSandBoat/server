-----------------------------------
-- ID: 4378
-- Item: Jug of Selbina Milk
-- Item Effect: regen: 1 HP/tick x 120sec, x 150sec w/ dream robe +1
-----------------------------------
require("scripts/globals/msg")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return 0
end

itemObject.onItemUse = function(target)
    if not target:hasStatusEffect(xi.effect.REGEN) then
        if target:getEquipID(xi.slot.BODY) == 14520 then -- Dream Robe +1
            target:addStatusEffect(xi.effect.REGEN, 1, 3, 150)
        else
            target:addStatusEffect(xi.effect.REGEN, 1, 3, 120)
        end
    else
        target:messageBasic(xi.msg.basic.NO_EFFECT)
    end
end

return itemObject
