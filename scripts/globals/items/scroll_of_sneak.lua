-----------------------------------
-- ID: 4745
-- Scroll of Sneak
-- Teaches the white magic Sneak
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.SNEAK)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.SNEAK)
end

return itemObject
