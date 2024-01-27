-----------------------------------
-- ID: 4715
-- Scroll of Reprisal
-- Teaches the white magic Reprisal
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.REPRISAL)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.REPRISAL)
end

return itemObject
