-----------------------------------
-- ID: 4794
-- Scroll of Aeroga III
-- Teaches the black magic Aeroga III
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.AEROGA_III)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.AEROGA_III)
end

return itemObject
