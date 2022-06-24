-----------------------------------
-- Area: Pashhow Marshlands
--  Mob: Brass Quadav
-----------------------------------
require("scripts/globals/regimes")
require("scripts/globals/follow")
local ID = require("scripts/zones/Pashhow_Marshlands/IDs")
-----------------------------------
local entity = {}

entity.onMobRoamAction = function(mob)
    if mob:getID() == ID.mob.BOWHO_WARMONGER + 1 then
        local leader = xi.follow.getFollowTarget(mob)
        if not leader or not leader:isSpawned() then return end

        if leader:isEngaged() then
            local leaderTarget = leader:getTarget()
            if leaderTarget then
                mob:updateEnmity(leaderTarget)
                return
            end
        end

        if mob:isFollowingPath() then
            return
        end
    end
end

entity.onMobDeath = function(mob, player, isKiller)
    xi.regime.checkRegime(player, mob, 60, 1, xi.regime.type.FIELDS)
end

return entity
