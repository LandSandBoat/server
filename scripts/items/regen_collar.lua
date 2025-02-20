-----------------------------------
-- ID: 15526
-- Item: Regen Collar
-- Item Effect: Restores 40 HP over 120 seconds
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.item.REGEN_COLLAR) then
        if not target:hasStatusEffect(xi.effect.REGEN) then
            target:addStatusEffect(xi.effect.REGEN, 1, 3, 120, 0, 0, 0, xi.effectSourceType.EQUIPPED_ITEM, xi.item.REGEN_COLLAR)
        else
            target:messageBasic(xi.msg.basic.NO_EFFECT)
        end
    end
end

return itemObject
