-----------------------------------
-- Area: RuAun Gardens
--  Mob: Groundskeeper
-- Note: Place holder Despot
-----------------------------------
local ID = require("scripts/zones/RuAun_Gardens/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 143, 2, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 144, 1, xi.regime.type.FIELDS)
    if optParams.isKiller then
        mob:setLocalVar("killer", player:getID())
    end
end

entity.onMobDespawn = function(mob)
    if xi.mob.phOnDespawn(mob, ID.mob.DESPOT_PH, 5, 7200, true) then -- 2 hours
        local phId = mob:getID()
        local nmId = ID.mob.DESPOT_PH[phId]
        GetMobByID(nmId):addListener("SPAWN", "PH_VAR", function(m)
            m:setLocalVar("ph", phId)
        end)
    end
end

return entity
