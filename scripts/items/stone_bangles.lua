-----------------------------------
-- ID: 14988
-- Stone Bangles
--  Enchantment: "Enstone"
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target)
    local fakeSpell = GetSpell(xi.magic.spell.ENSTONE)
    xi.spells.enhancing.useEnhancingSpell(target, target, fakeSpell)
end

return itemObject
