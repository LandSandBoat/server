-----------------------------------
-- ID: 14992
-- Water Mitts
--  Enchantment: "Enwater"
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target)
    local fakeSpell = GetSpell(xi.magic.spell.ENWATER)
    xi.spells.enhancing.useEnhancingSpell(target, target, fakeSpell)
end

return itemObject
