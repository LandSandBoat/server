-----------------------------------
-- ID: 13144
-- Item: wing gorget
-- Item Effect: gives regain
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.item.WING_GORGET) then
        if target:hasStatusEffect(xi.effect.REGAIN) then
            target:messageBasic(xi.msg.basic.NO_EFFECT)
        else
            target:addStatusEffect(xi.effect.REGAIN, 5, 3, 30, 0, 0, 0, xi.effectSourceType.EQUIPPED_ITEM, xi.item.WING_GORGET)
        end
    end
end

return itemObject
