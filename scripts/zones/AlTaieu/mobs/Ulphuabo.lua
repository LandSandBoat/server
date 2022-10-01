-----------------------------------
-- Area: Al'Taieu
--  Mob: Ul'phuabo
-----------------------------------
require("scripts/globals/missions")
require("scripts/globals/status")
mixins = { require("scripts/mixins/families/phuabo") }
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
