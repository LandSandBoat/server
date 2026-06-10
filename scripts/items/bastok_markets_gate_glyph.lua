-----------------------------------
-- ID: 4188
-- Bastok Markets Gate Glyph
-- Transports the user to the Bastok Markets gate
-- (near Rabid Wolf, I.M.)
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    return 0
end

itemObject.onItemUse = function(target, user)
    target:addStatusEffect(xi.effect.TELEPORT, { power = xi.teleport.id.BASTOK_MARKETS_GLYPH, duration = 3, origin = user, icon = 0 })
end

return itemObject
