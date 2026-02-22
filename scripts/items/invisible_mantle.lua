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

itemObject.onItemUse = function(target, user)
    if target:hasEquipped(xi.item.INVISIBLE_MANTLE) then
        if target:hasStatusEffect(xi.effect.INVISIBLE) then
            target:messageBasic(xi.msg.basic.NO_EFFECT)
        else
            target:addStatusEffect(xi.effect.INVISIBLE, { duration = math.floor(180 * xi.settings.main.SNEAK_INVIS_DURATION_MULTIPLIER), origin = user, tick = 10, sourceType = xi.effectSourceType.EQUIPPED_ITEM, sourceTypeParam = xi.item.INVISIBLE_MANTLE })
        end
    end
end

return itemObject
