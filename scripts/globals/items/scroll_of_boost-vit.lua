-----------------------------------
-- ID: 5096
-- Scroll of Boost-VIT
-- Teaches the white magic Boost-VIT
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.BOOST_VIT)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.BOOST_VIT)
end

return itemObject
