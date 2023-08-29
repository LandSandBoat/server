-----------------------------------
-- ID: 13144
-- Item: wing gorget
-- Item Effect: gives regain
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local effect = target:getStatusEffect(xi.effect.REGAIN)
    if effect ~= nil and effect:getItemSourceID() == xi.items.WING_GORGET then
        target:delStatusEffect(xi.effect.REGAIN)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.items.WING_GORGET) then
        if target:hasStatusEffect(xi.effect.REGAIN) then
            target:messageBasic(xi.msg.basic.NO_EFFECT)
        else
            target:addStatusEffect(xi.effect.REGAIN, 5, 3, 30, 0, 0, 0, xi.items.WING_GORGET)
        end
    end
end

return itemObject
