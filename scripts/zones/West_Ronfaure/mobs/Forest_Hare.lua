-----------------------------------
-- Area: West Ronfaure
--  Mob: Forest Hare
-- Note: PH for Jaggedy-Eared Jack
-----------------------------------
local ID = zones[xi.zone.WEST_RONFAURE]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 2, 1, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    local params = { }
    xi.mob.phOnDespawn(mob, ID.mob.JAGGEDY_EARED_JACK, 9, 2400, params) -- 40 minute minimum
end

return entity
