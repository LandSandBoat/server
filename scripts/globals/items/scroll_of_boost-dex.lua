-----------------------------------
-- ID: 5095
-- Scroll of Boost-DEX
-- Teaches the white magic Boost-DEX
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.BOOST_DEX)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.BOOST_DEX)
end

return itemObject
