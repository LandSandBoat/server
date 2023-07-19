-----------------------------------
-- ID: 4713
-- Scroll of Enwater
-- Teaches the white magic Enwater
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.ENWATER)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.ENWATER)
end

return itemObject
