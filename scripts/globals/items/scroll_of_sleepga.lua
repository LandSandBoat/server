-----------------------------------
-- ID: 4881
-- Scroll of Sleepga
-- Teaches the black magic Sleepga
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.SLEEPGA)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.SLEEPGA)
end

return itemObject
