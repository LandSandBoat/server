-----------------------------------
-- Area: Vunkerl Inlet [S]
--  Mob: Gnole
-----------------------------------
local entity = {}

mixins = { require("scripts/mixins/families/gnole") }

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
