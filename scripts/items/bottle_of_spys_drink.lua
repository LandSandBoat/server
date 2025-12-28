-----------------------------------
-- ID: 5389
-- Item: bottle_of_spys_drink
-- Item Effect: Haste +30%
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target)
    local effect   = xi.effect.HASTE
    local power    = 3000
    local duration = 90

    if not target:hasStatusEffect(xi.effect.HASTE) then
        xi.itemUtils.addItemEffect(target, effect, power, duration)
    else
        target:messageBasic(xi.msg.basic.NO_EFFECT)
    end
end

return itemObject
