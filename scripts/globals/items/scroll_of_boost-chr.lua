-----------------------------------
-- ID: 5100
-- Scroll of Boost-CHR
-- Teaches the white magic Boost-CHR
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.BOOST_CHR)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.BOOST_CHR)
end

return itemObject
