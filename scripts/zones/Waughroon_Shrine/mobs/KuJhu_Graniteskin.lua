-----------------------------------
-- Area: Waughroon Shrine
--  Mob: Ku'Jhu Graniteskin
-- BCNM mob in Bastok mission 7-2.
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
