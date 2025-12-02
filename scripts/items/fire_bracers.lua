-----------------------------------
-- ID: 14991
-- Fire Bracers
--  Enchantment: "Enfire"
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target)
    local fakeSpell = GetSpell(xi.magic.spell.ENFIRE)
    xi.spells.enhancing.useEnhancingSpell(target, target, fakeSpell)
end

return itemObject
