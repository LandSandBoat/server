-----------------------------------
-- ID: 13170
-- Item: Stoneskin Torque
-- Item Effect: Stoneskin
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.item.STONESKIN_TORQUE) then
        if target:addStatusEffect(xi.effect.STONESKIN, 104, 0, 300, 0, 0, 4, xi.effectSourceType.EQUIPPED_ITEM, xi.item.STONESKIN_TORQUE) then
            target:messageBasic(xi.msg.basic.GAINS_EFFECT_OF_STATUS, xi.effect.STONESKIN)
        else
            target:messageBasic(xi.msg.basic.NO_EFFECT)
        end
    end
end

return itemObject
