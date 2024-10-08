-----------------------------------
-- ID: 4658
-- Scroll of Shell III
-- Teaches the white magic Shell III
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.SHELL_III)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.SHELL_III)
end

return itemObject
