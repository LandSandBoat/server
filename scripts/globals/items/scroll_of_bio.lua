-----------------------------------
-- ID: 4838
-- Scroll of Bio
-- Teaches the black magic Bio
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.BIO)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.BIO)
end

return itemObject
