-----------------------------------
-- ID: 4741
-- Scroll of Shellra IV
-- Teaches the white magic Shellra IV
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.SHELLRA_IV)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.SHELLRA_IV)
end

return itemObject
