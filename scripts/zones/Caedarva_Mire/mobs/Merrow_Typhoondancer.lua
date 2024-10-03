-----------------------------------
-- Area: Caedarva Mire (79)
--  Mob: Merrow Typhoondancer
-- Note: Minion of Experimental Lamia
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.applyMixins(mob, xi.mixins.job_special)
    xi.applyMixins(mob, xi.mixins.weapon_break)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
