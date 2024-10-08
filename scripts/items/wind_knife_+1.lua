-----------------------------------
-- ID: 20568
-- wind_knife_+1
-- Enchantment: Casts Aero
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(user, target)
    -- user:castSpell(xi.magic.spell.AERO, target)
    user:printToPlayer('Wind Knife +1 : enchantment implementation untested.')
end

return itemObject
