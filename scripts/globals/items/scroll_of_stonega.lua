-----------------------------------
-- ID: 4797
-- Scroll of Stonega
-- Teaches the black magic Stonega
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.STONEGA)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.STONEGA)
end

return itemObject
