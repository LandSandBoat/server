-----------------------------------
-- ID: 4770
-- Scroll of Stone IV
-- Teaches the black magic Stone IV
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.STONE_IV)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.STONE_IV)
end

return itemObject
