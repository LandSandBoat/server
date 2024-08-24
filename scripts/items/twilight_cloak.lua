-----------------------------------
-- ID: 11363
-- Equip: Twilight Cloak
-- Able to cast "Impact"
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
end

itemObject.onItemEquip = function(target, item)
    target:addSpell(xi.magic.spell.IMPACT)
end

itemObject.onItemUnequip = function(target, item)
    target:delSpell(xi.magic.spell.IMPACT)
end

return itemObject
