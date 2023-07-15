-----------------------------------
-- ID: 13685
-- Item: Invisible Mantle
-- Item Effect: gives invisible
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local effect = target:getStatusEffect(xi.effect.INVISIBLE)
    if effect ~= nil and effect:getItemSourceID() == xi.items.INVISIBLE_MANTLE then
        target:delStatusEffect(xi.effect.INVISIBLE)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.items.INVISIBLE_MANTLE) then
        if target:hasStatusEffect(xi.effect.INVISIBLE) then
            target:messageBasic(xi.msg.basic.NO_EFFECT)
        else
            target:addStatusEffect(xi.effect.INVISIBLE, 0, 10, math.floor(180 * xi.settings.main.SNEAK_INVIS_DURATION_MULTIPLIER), 0, 0, 0, xi.items.INVISIBLE_MANTLE)
        end
    end
end

return itemObject
