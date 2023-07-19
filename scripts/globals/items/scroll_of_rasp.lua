-----------------------------------
-- ID: 4846
-- Scroll of Rasp
-- Teaches the black magic Rasp
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.RASP)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.RASP)
end

return itemObject
