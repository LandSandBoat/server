-----------------------------------
-- Area: West Ronfaure
--  Mob: Forest Hare
-- Note: PH for Jaggedy-Eared Jack
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
	-- Set respawn time in seconds
	mob:setRespawnTime(30)

    -- Only award regime credit if we have a valid killer
    if player ~= nil and optParams ~= nil and optParams.isKiller then
        xi.regime.checkRegime(player, mob, 2, 1, xi.regime.type.FIELDS)
    end
end

entity.onMobDespawn = function(mob)
    local params = { }
    xi.mob.phOnDespawn(mob, ID.mob.JAGGEDY_EARED_JACK, 9, 1800, params) -- 30 minute minimum
end

return entity