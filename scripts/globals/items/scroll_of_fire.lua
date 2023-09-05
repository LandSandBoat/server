-----------------------------------
-- ID: 4752
-- Scroll of Fire
-- Teaches the black magic Fire
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.FIRE)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.FIRE)
end

return itemObject
