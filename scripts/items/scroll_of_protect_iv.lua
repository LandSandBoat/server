-----------------------------------
-- ID: 4654
-- Scroll of Protect IV
-- Teaches the white magic Protect IV
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.PROTECT_IV)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.PROTECT_IV)
end

return itemObject
