-----------------------------------
-- Area: Al'Taieu
--   NM: Jailer of Prudence
-- AnimationSubs: 0 - Normal, 3 - Mouth Open
-----------------------------------
local ID = require("scripts/zones/AlTaieu/IDs")
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/status")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
end

function onMobSpawn(mob)
    tpz.mix.jobSpecial.config(mob, {
        specials =
        {
            {
                id = tpz.jsa.PERFECT_DODGE,
                cooldown = 120, -- "Both can use Perfect Dodge multiple times, and will do so almost incessantly." (guessing a 2 minute cooldown)
                hpp = 95,
                endCode = function(mob)
                    mob:addStatusEffectEx(tpz.effect.FLEE, 0, 100, 0, 30) -- "Jailer of Prudence will however gain Flee speed during Perfect Dodge."
                end,
            },
        },
    })

    mob:AnimationSub(0) -- Mouth closed
    mob:addStatusEffectEx(tpz.effect.FLEE, 0, 100, 0, 60)
    mob:setMod(tpz.mod.TRIPLE_ATTACK, 20)
    mob:setMod(tpz.mod.REGEN, 10)
    mob:addMod(tpz.mod.BINDRES, 30)
    mob:addMod(tpz.mod.SLOWRES, 10)
    mob:addMod(tpz.mod.BLINDRES, 10)
    mob:addMod(tpz.mod.SLEEPRES, 30)
    mob:addMod(tpz.mod.PETRIFYRES, 10)
    mob:addMod(tpz.mod.GRAVITYRES, 10)
    mob:addMod(tpz.mod.LULLABYRES, 30)
end

function onMobDisEngage(mob, target)
end

--[[ onMobskill -- When this functionlity is added, this should work.
function onUseAbility(mob, target, ability)
    local mobId = mob:getID()
    local pOne = GetMobByID(ID.mob.JAILER_OF_PRUDENCE_1)
    local pTwo = GetMobByID(ID.mob.JAILER_OF_PRUDENCE_2)
    local pOneAct = pOne:getCurrentAction()
    local pTwoAct = pTwo:getCurrentAction()

    if ability:getID() == 437 then -- Perfect Dodge
        mob:addStatusEffectEx(tpz.effect.FLEE, 0, 100, 0, 30)
    elseif mobId == ID.mob.JAILER_OF_PRUDENCE_1 and pTwoAct > 0 and pTwoAct ~= tpz.act.SLEEP and pTwoAct ~= tpz.act.STUN and pTwo:checkDistance(mob) <= 10 then
        pTwo:useMobAbility(ability:getID())
    elseif mobId == ID.mob.JAILER_OF_PRUDENCE_2 and pOneAct > 0 and pOneAct ~= tpz.act.SLEEP and pOneAct ~= tpz.act.STUN and pOne:checkDistance(mob) <= 10 then
        pOne:useMobAbility(ability:getID())
    end
end
--]]

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    local firstPrudence     = GetMobByID(ID.mob.JAILER_OF_PRUDENCE_1)
    local secondPrudence    = GetMobByID(ID.mob.JAILER_OF_PRUDENCE_2)
    if (mob:getID() == ID.mob.JAILER_OF_PRUDENCE_1) then
        secondPrudence:setMobMod(tpz.mobMod.NO_DROPS, 0)
        secondPrudence:AnimationSub(3) -- Mouth Open
        secondPrudence:addMod(tpz.mod.ATTP, 100)
        secondPrudence:delMod(tpz.mod.DEFP, -50)
    else
        firstPrudence:setMobMod(tpz.mobMod.NO_DROPS, 0)
        firstPrudence:AnimationSub(3) -- Mouth Open
        firstPrudence:addMod(tpz.mod.ATTP, 100)
        firstPrudence:delMod(tpz.mod.DEFP, -50)
    end
end
