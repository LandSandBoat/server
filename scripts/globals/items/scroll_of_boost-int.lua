-----------------------------------
-- ID: 5098
-- Scroll of Boost-INT
-- Teaches the white magic Boost-INT
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.BOOST_INT)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.BOOST_INT)
end

return itemObject
