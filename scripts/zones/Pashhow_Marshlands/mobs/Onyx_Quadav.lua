-----------------------------------
-- Area: Pashhow Marshlands
--  Mob: Onyx Quadav
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobRoamAction = function(mob)
    if mob:getID() == ID.mob.BOWHO_WARMONGER + 2 then
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
