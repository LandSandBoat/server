-----------------------------------
-- Area: Dynamis - Windurst
--  Mob: Naa Yixo the Stillrage
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.applyMixins(mob, xi.mixins.dynamis_beastmen)
    xi.applyMixins(mob, xi.mixins.job_special)
    xi.applyMixins(mob, xi.mixins.remove_doom)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
