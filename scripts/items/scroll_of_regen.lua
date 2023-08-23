-----------------------------------
-- ID: 4716
-- Scroll of Regen
-- Teaches the white magic Regen
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.REGEN)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.REGEN)
end

return itemObject
