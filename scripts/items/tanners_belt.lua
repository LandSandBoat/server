-----------------------------------
-- ID: 15448
-- Item: Tanners belt
-- Enchantment: Synthesis image support
-- Duration: 8Min
-- Leathercraft Skill +3
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    if target:hasStatusEffect(xi.effect.LEATHERCRAFT_IMAGERY) then
        return xi.msg.basic.ITEM_UNABLE_TO_USE
    end

    return 0
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.LEATHERCRAFT_IMAGERY, 3, 0, 480)
end

return itemObject
