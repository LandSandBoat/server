-----------------------------------
-- ID: 4931
-- Scroll of Hyoton: Ni
-- Teaches the ninjutsu Hyoton: Ni
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.HYOTON_NI)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.HYOTON_NI)
end

return itemObject
