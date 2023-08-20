-----------------------------------
-- ID: 4894
-- Scroll of Thundaj
-- Teaches the black magic Thundaj
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.THUNDAJA)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.THUNDAJA)
end

return itemObject
