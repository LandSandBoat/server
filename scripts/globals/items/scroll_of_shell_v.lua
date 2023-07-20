-----------------------------------
-- ID: 4660
-- Scroll of Shell V
-- Teaches the white magic Shell V
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.SHELL_V)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.SHELL_V)
end

return itemObject
