-----------------------------------
-- ID: 14990
-- Blizzard Gloves
--  Enchantment: "Enblizzard"
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target)
    local fakeSpell = GetSpell(xi.magic.spell.ENBLIZZARD)
    xi.spells.enhancing.useEnhancingSpell(target, target, fakeSpell)
end

return itemObject
