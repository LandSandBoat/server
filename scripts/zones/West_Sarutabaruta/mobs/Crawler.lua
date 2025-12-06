-----------------------------------
-- Area: West Sarutabaruta
--  Mob: Crawler
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
	-- Set respawn time in seconds
	mob:setRespawnTime(30)

    -- Only award regime credit if we have a valid killer
    if player ~= nil and optParams ~= nil and optParams.isKiller then
        xi.regime.checkRegime(player, mob, 28, 1, xi.regime.type.FIELDS)
        xi.regime.checkRegime(player, mob, 29, 2, xi.regime.type.FIELDS)
    end
end

return entity