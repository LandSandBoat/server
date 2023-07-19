-----------------------------------
-- ID: 4825
-- Scroll of Gravity II
-- Teaches the black magic Gravity II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.GRAVITY_II)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.GRAVITY_II)
end

return itemObject
