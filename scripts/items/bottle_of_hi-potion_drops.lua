-----------------------------------
-- ID: 5328
-- Item: Hi-Potion Drop
-- Item Effect: Restores 110 HP
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    if target:hasStatusEffect(xi.effect.MEDICINE) then
        return xi.msg.basic.ITEM_NO_USE_MEDICATED
    end

    return 0
end

itemObject.onItemUse = function(target)
    target:addHP(110 * xi.settings.main.ITEM_POWER)
    target:addStatusEffect(xi.effect.MEDICINE, 0, 0, 300)
end

return itemObject
