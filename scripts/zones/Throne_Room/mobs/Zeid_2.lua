-----------------------------------
-- Area: Throne Room
--  Mob: Zeid (Phase 2)
-- Mission 9-2 BASTOK BCNM Fight
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            { id = xi.jsa.BLOOD_WEAPON, hpp = math.random(20, 50) },
        },
    })
end

entity.onMobFight = function(mob, target)
    local zeid = mob:getID()
    local shadow1 = GetMobByID(zeid + 1)
    local shadow2 = GetMobByID(zeid + 2)

    if
        mob:getHPP() <= 77 and
        mob:getTP() >= 1000 and
        shadow1:isDead() and
        shadow2:isDead()
    then
        mob:useMobAbility(984)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    DespawnMob(mob:getID() + 1)
    DespawnMob(mob:getID() + 2)
end

return entity
