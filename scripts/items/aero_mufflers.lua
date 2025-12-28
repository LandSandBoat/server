-----------------------------------
-- ID: 14989
-- Aero Mufflers
-- Enchantment: "Enaero"
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target)
    local fakeSpell = GetSpell(xi.magic.spell.ENAERO)
    xi.spells.enhancing.useEnhancingSpell(target, target, fakeSpell)
end

return itemObject
