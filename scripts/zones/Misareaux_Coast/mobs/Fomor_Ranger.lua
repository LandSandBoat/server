-----------------------------------
-- Area: Misareaux_Coast
--  Mob: Fomor Ranger
-----------------------------------
mixins = { require("scripts/mixins/fomor_hate") }
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
