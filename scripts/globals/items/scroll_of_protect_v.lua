-----------------------------------
-- ID: 4655
-- Scroll of Protect V
-- Teaches the white magic Protect V
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.PROTECT_V)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.PROTECT_V)
end

return itemObject
