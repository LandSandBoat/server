-----------------------------------
-- ID: 4929
-- Scroll of Katon: Ni
-- Teaches the ninjutsu Katon: Ni
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.KATON_NI)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.KATON_NI)
end

return itemObject
