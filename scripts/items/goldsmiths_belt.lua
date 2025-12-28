-----------------------------------
-- ID: 15446
-- Item: Goldsmith's Belt
-- Enchantment: Synthesis image support
-- Duration: 8Min
-- Goldsmithing Skill +3
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    if target:hasStatusEffect(xi.effect.GOLDSMITHING_IMAGERY) then
        return xi.msg.basic.ITEM_UNABLE_TO_USE
    end

    return 0
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.GOLDSMITHING_IMAGERY, 3, 0, 480)
end

return itemObject
