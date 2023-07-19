-----------------------------------
-- ID: 4656
-- Scroll of Shell
-- Teaches the white magic Shell
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.SHELL)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.SHELL)
end

return itemObject
