-----------------------------------
--  MOB: Sewer Syrup
-- Area: Nyzul Isle
-- Info: NM
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.GIL_MIN, 4000)
    mob:setMobMod(xi.mobMod.GIL_MAX, 19000)
    mob:setMobMod(xi.mobMod.MUG_GIL, 3500)
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        xi.nyzul.spawnChest(mob, player)
        xi.nyzul.eliminateAllKill(mob)
    end
end

return entity
