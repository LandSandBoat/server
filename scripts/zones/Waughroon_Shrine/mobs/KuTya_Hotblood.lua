-----------------------------------
-- Area: Waughroon Shrine
--  Mob: Ku'Tya Hotblood
-- BCNM: Grimshell Shocktroopers
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
