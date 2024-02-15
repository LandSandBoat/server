-----------------------------------
-- Area: Al'Taieu
--   NM: Jailer of Prudence
-- AnimationSubs: 0 - Normal, 3 - Mouth Open
-----------------------------------
local ID = zones[xi.zone.ALTAIEU]
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.NO_DROPS, 1)

    mob:addListener('WEAPONSKILL_BEFORE_USE', 'JOP_WS_MIRROR', function(mobArg, skillid)
        if mobArg:getLocalVar('mirrored_ws') == 1 then
            mobArg:setLocalVar('mirrored_ws', 0)
            return
        end

        local otherPrudence = mobArg:getID() == ID.mob.JAILER_OF_PRUDENCE_1 and GetMobByID(ID.mob.JAILER_OF_PRUDENCE_2) or GetMobByID(ID.mob.JAILER_OF_PRUDENCE_1)

        if otherPrudence:isAlive() and otherPrudence:checkDistance(mob) <= 50 then
            otherPrudence:setLocalVar('mirrored_ws', 1)
            otherPrudence:useMobAbility(skillid)
        end
    end)
end

entity.onMobSpawn = function(mob)
    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            {
                id = xi.jsa.PERFECT_DODGE,
                cooldown = 120, -- "Both can use Perfect Dodge multiple times, and will do so almost incessantly." (guessing a 2 minute cooldown)
                hpp = 95,
                endCode = function(mobArg)
                    mobArg:addStatusEffectEx(xi.effect.FLEE, 0, 100, 0, 30) -- "Jailer of Prudence will however gain Flee speed during Perfect Dodge."
                end,
            },
        },
    })

    mob:setAnimationSub(0) -- Mouth closed
    mob:addStatusEffectEx(xi.effect.FLEE, 0, 100, 0, 60)
    mob:setMod(xi.mod.TRIPLE_ATTACK, 20)
    mob:setMod(xi.mod.REGEN, 10)
    mob:addMod(xi.mod.BIND_MEVA, 30)
    mob:addMod(xi.mod.SLOW_MEVA, 10)
    mob:addMod(xi.mod.BLIND_MEVA, 10)
    mob:addMod(xi.mod.SLEEP_MEVA, 30)
    mob:addMod(xi.mod.PETRIFY_MEVA, 10)
    mob:addMod(xi.mod.GRAVITY_MEVA, 10)
    mob:addMod(xi.mod.LULLABY_MEVA, 30)
end

entity.onMobDisengage = function(mob)
end

entity.onMobDeath = function(mob, player, optParams)
    local firstPrudence  = GetMobByID(ID.mob.JAILER_OF_PRUDENCE_1)
    local secondPrudence = GetMobByID(ID.mob.JAILER_OF_PRUDENCE_2)
    local count          = player:getLocalVar('prudenceCount')

    if firstPrudence or secondPrudence then
        player:setLocalVar('prudenceCount', count + 1)
    end

    if count >= 2 and player:hasEminenceRecord(770) then
        xi.roe.onRecordTrigger(player, 770)
        player:setLocalVar('prudenceCount', 0)
    end
end

entity.onMobDespawn = function(mob)
    local firstPrudence  = GetMobByID(ID.mob.JAILER_OF_PRUDENCE_1)
    local secondPrudence = GetMobByID(ID.mob.JAILER_OF_PRUDENCE_2)

    if mob:getID() == ID.mob.JAILER_OF_PRUDENCE_1 then
        secondPrudence:setMobMod(xi.mobMod.NO_DROPS, 0)
        secondPrudence:setAnimationSub(3) -- Mouth Open
        secondPrudence:addMod(xi.mod.ATTP, 100)
        secondPrudence:delMod(xi.mod.DEFP, -50)
    else
        firstPrudence:setMobMod(xi.mobMod.NO_DROPS, 0)
        firstPrudence:setAnimationSub(3) -- Mouth Open
        firstPrudence:addMod(xi.mod.ATTP, 100)
        firstPrudence:delMod(xi.mod.DEFP, -50)
    end
end

return entity
