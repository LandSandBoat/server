-----------------------------------
-- ID: 4956
-- Scroll of Kurayami: Ni
-- Teaches the ninjutsu Kurayami: Ni
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.KURAYAMI_NI)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.KURAYAMI_NI)
end

return itemObject
