-----------------------------------
-- ID: 13685
-- Item: Invisible Mantle
-- Item Effect: gives invisible
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.item.INVISIBLE_MANTLE) then
        if target:hasStatusEffect(xi.effect.INVISIBLE) then
            target:messageBasic(xi.msg.basic.NO_EFFECT)
        else
            target:addStatusEffect(xi.effect.INVISIBLE, 0, 10, math.floor(180 * xi.settings.main.SNEAK_INVIS_DURATION_MULTIPLIER), 0, 0, 0, xi.effectSourceType.EQUIPPED_ITEM, xi.item.INVISIBLE_MANTLE)
        end
    end
end

return itemObject
