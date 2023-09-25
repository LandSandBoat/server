-----------------------------------
-- Area: Arrapago Reef
--   NM: Bukki
-----------------------------------
mixins =
{
    require("scripts/mixins/families/imp"),
    require("scripts/mixins/job_special")
}
-----------------------------------
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
end

entity.onMobEngage = function(mob, target)
    mob:useMobAbility(1710, target)
end

entity.onMobFight = function(mob, target)
    local battleTime = mob:getBattleTime()

    if mob:getLocalVar("jaTime") < battleTime then
        if mob:getHPP() > 20 then
            mob:setLocalVar("jaTime", battleTime + math.random(10, 60))
            mob:useMobAbility(1710, target)
        else
            mob:setLocalVar("jaTime", battleTime + math.random(5, 10))
            mob:useMobAbility(1711, target)
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
