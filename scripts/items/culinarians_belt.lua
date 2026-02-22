-----------------------------------
-- ID: 15451
-- Item: Culinarian's Belt
-- Enchantment: Synthesis image support
-- Duration: 8Min
-- Cooking Skill +3
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    if target:hasStatusEffect(xi.effect.COOKING_IMAGERY) then
        return xi.msg.basic.ITEM_UNABLE_TO_USE
    end

    return 0
end

itemObject.onItemUse = function(target, user)
    target:addStatusEffect(xi.effect.COOKING_IMAGERY, { power = 3, duration = 480, origin = user })
end

return itemObject
