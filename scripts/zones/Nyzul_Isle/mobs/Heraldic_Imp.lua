-----------------------------------
--  MOB: Heraldic Imp
-- Area: Nyzul Isle
-- Info: Specified Mob Group
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        xi.nyzul.spawnChest(mob, player)
        xi.nyzul.specifiedGroupKill(mob)
    end
end

return entity
