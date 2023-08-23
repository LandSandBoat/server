-----------------------------------
-- ID: 5094
-- Scroll of Boost-STR
-- Teaches the white magic Boost-STR
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.BOOST_STR)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.BOOST_STR)
end

return itemObject
