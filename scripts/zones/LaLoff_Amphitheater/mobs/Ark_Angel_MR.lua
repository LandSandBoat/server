-----------------------------------
-- Area: LaLoff Amphitheater
--  Mob: Ark Angel MR
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/status")
-----------------------------------

-- TODO: Allegedly has a 12 hp/sec regen.  Determine if true, and add to onMobInitialize if so.

function onMobSpawn(mob)
    tpz.mix.jobSpecial.config(mob, {
        specials =
        {
            {id = tpz.jsa.PERFECT_DODGE},
        },
    })
end

function onMobEngaged(mob, target)
    --[[ TODO:
        Summons pet when party is engaged.  Randomly chosen between Tiger and Mandragora.
        Current victory system doesn't readily support a random choice of pet while having
        the pet as a victory condition.  Therefore, Mandragora just isn't used at this time.
    ]]

    local mobid = mob:getID()

    for member = mobid-1, mobid+6 do
        local m = GetMobByID(member)
        if m:getCurrentAction() == tpz.act.ROAMING then
            m:updateEnmity(target)
        end
    end
end

function onMobFight(mob, target)
    local charm = mob:getLocalVar("Charm")

    if (charm == 0 and mob:getHPP() <  50) then
        mob:useMobAbility(710)
        mob:setLocalVar("Charm", 1)
    end
end

function onMobDeath(mob, player, isKiller)
end
