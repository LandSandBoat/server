-----------------------------------
-- ID: 4691
-- Scroll of Baramnesra
-- Teaches the white magic Baramnesra
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.BARAMNESRA)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.BARAMNESRA)
end

return itemObject
