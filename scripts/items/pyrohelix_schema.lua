-----------------------------------
-- ID: 6041
-- Pyrohelix Schema
-- Teaches the black magic Pyrohelix
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.PYROHELIX)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.PYROHELIX)
end

return itemObject
