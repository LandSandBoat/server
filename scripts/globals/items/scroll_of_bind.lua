-----------------------------------
-- ID: 4866
-- Scroll of Bind
-- Teaches the black magic Bind
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.BIND)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.BIND)
end

return itemObject
