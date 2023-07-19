-----------------------------------
-- ID: 5099
-- Scroll of Boost-MND
-- Teaches the white magic Boost-MND
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.BOOST_MND)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.BOOST_MND)
end

return itemObject
