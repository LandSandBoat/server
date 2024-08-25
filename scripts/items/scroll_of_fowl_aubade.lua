-----------------------------------
-- ID: 5013
-- Scroll of Fowl Aubade
-- Teaches the song Fowl Aubade
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.FOWL_AUBADE)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.FOWL_AUBADE)
end

return itemObject
