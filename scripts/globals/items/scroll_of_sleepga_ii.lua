-----------------------------------
-- ID: 4882
-- Scroll of Sleepga II
-- Teaches the black magic Sleepga II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.SLEEPGA_II)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.SLEEPGA_II)
end

return itemObject
