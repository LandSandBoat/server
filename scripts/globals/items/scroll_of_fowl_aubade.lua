-----------------------------------
-- ID: 5013
-- Scroll of Fowl Aubade
-- Teaches the song Fowl Aubade
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.FOWL_AUBADE)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.FOWL_AUBADE)
end

return itemObject
