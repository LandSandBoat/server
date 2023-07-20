-----------------------------------
-- ID: 4814
-- Scroll of Freeze
-- Teaches the black magic Freeze
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.FREEZE)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.FREEZE)
end

return itemObject
