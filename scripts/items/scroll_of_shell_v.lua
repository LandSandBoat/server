-----------------------------------
-- ID: 4660
-- Scroll of Shell V
-- Teaches the white magic Shell V
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.SHELL_V)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.SHELL_V)
end

return itemObject
