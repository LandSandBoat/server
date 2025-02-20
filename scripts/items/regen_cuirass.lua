-----------------------------------
-- ID: 15170
-- Item: regen cuirass
-- Item Effect: gives regen
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.item.REGEN_CUIRASS) then
        if target:hasStatusEffect(xi.effect.REGEN) then
            target:messageBasic(xi.msg.basic.NO_EFFECT)
        else
            target:addStatusEffect(xi.effect.REGEN, 15, 3, 180, 0, 0, 0, xi.effectSourceType.EQUIPPED_ITEM, xi.item.REGEN_CUIRASS)
        end
    end
end

return itemObject
