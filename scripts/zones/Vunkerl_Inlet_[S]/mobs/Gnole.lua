-----------------------------------
-- Area: Vunkerl Inlet [S]
--  Mob: Gnole
-----------------------------------
local entity = {}

mixins = { require("scripts/mixins/families/gnole") }

entity.onMobDeath = function(mob, player, optParams)
end

return entity
