-----------------------------------
-- ID: 4738
-- Scroll of Shellra
-- Teaches the white magic Shellra
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.SHELLRA)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.SHELLRA)
end

return itemObject
