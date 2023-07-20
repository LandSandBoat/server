-----------------------------------
-- ID: 6043
-- Ionohelix Schema
-- Teaches the black magic Ionohelix
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.IONOHELIX)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.IONOHELIX)
end

return itemObject
