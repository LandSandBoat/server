-----------------------------------
-- Area: Al'Taieu
--  Mob: Om'phuabo
-----------------------------------
require("scripts/globals/missions")
mixins = { require("scripts/mixins/families/phuabo") }
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
