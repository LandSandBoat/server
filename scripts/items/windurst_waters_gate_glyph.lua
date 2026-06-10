-----------------------------------
-- ID: 4193
-- Windurst Waters Gate Glyph
-- Transports the user to the Windurst Waters gate
-- (near Puroiko-Maiko, W.W.)
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    return 0
end

itemObject.onItemUse = function(target, user)
    target:addStatusEffect(xi.effect.TELEPORT, { power = xi.teleport.id.WINDY_WATERS_GLYPH, duration = 3, origin = user, icon = 0 })
end

return itemObject
