-----------------------------------
-- ID: 4775
-- Scroll of Thunder IV
-- Teaches the black magic Thunder IV
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.THUNDER_IV)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.THUNDER_IV)
end

return itemObject
