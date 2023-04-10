-----------------------------------
-- ID: 20568
-- wind_knife_+1
-- Enchantment: Casts Aero
-----------------------------------
require("scripts/globals/spell_data")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return 0
end

itemObject.onItemUse = function(user, target)
    -- user:castSpell(xi.magic.spell.AERO, target)
    user:PrintToPlayer("Wind Knife +1 : enchantment implementation untested.")
end

return itemObject
