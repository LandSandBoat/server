-----------------------------------
-- ID: 15526
-- Item: Regen Collar
-- Item Effect: Restores 40 HP over 120 seconds
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local effect = target:getStatusEffect(xi.effect.REGEN)
    if effect ~= nil and effect:getItemSourceID() == xi.items.REGEN_COLLAR then
        target:delStatusEffect(xi.effect.REGEN)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.items.REGEN_COLLAR) then
        if not target:hasStatusEffect(xi.effect.REGEN) then
            target:addStatusEffect(xi.effect.REGEN, 1, 3, 120, 0, 0, 0, xi.items.REGEN_COLLAR)
        else
            target:messageBasic(xi.msg.basic.NO_EFFECT)
        end
    end
end

return itemObject
