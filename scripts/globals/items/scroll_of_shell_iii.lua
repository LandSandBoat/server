-----------------------------------
-- ID: 4658
-- Scroll of Shell III
-- Teaches the white magic Shell III
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.SHELL_III)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.SHELL_III)
end

return itemObject
