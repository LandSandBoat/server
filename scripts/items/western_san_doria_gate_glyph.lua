-----------------------------------
-- ID: 4191
-- Western San d'Oria Gate Glyph
-- Transports the user to the western Southern San d'Oria gate
-- (near Aravoge, T.K.)
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    return 0
end

itemObject.onItemUse = function(target, user)
    target:addStatusEffect(xi.effect.TELEPORT, { power = xi.teleport.id.WEST_SANDY_GLYPH, duration = 3, origin = user, icon = 0 })
end

return itemObject
