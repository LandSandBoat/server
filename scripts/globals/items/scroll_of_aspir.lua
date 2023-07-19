-----------------------------------
-- ID: 4855
-- Scroll of Aspir
-- Teaches the black magic Aspir
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.ASPIR)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.ASPIR)
end

return itemObject
