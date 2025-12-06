-----------------------------------
-- Area: West Ronfaure
--  Mob: Scarab Beetle
-- Note: PH for Fungus Beetle
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
	-- Set respawn time in seconds
	mob:setRespawnTime(30)

    -- Only award regime credit if we have a valid killer
    if player ~= nil and optParams ~= nil and optParams.isKiller then
        xi.regime.checkRegime(player, mob, 3, 1, xi.regime.type.FIELDS)
        xi.regime.checkRegime(player, mob, 4, 2, xi.regime.type.FIELDS)
    end
end

entity.onMobDespawn = function(mob)
    local params = { }
    xi.mob.phOnDespawn(mob, ID.mob.FUNGUS_BEETLE, 10, 900, params) -- 15 minute minimum
end

return entity