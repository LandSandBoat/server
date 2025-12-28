-----------------------------------
-- ID: 15445
-- Item: Blacksmith's Belt
-- Enchantment: Synthesis image support
-- Duration: 8Min
-- Smithing Skill +3
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    if target:hasStatusEffect(xi.effect.SMITHING_IMAGERY) then
        return xi.msg.basic.ITEM_UNABLE_TO_USE
    end

    return 0
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.SMITHING_IMAGERY, 3, 0, 480)
end

return itemObject
