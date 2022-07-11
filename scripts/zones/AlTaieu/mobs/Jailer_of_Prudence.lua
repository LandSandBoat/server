-----------------------------------
-- Area: Al'Taieu
--   NM: Jailer of Prudence
-- AnimationSubs: 0 - Normal, 3 - Mouth Open
-----------------------------------
local ID = require("scripts/zones/AlTaieu/IDs")
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/status")
-----------------------------------
local entity = {}

local teleport = function(mob, hideDuration) --special move to new target option
    if mob:isDead() then
        return
    end
    mob:addStatusEffectEx(xi.effect.FLEE, 0, 100, 0, 60)
    mob:hideName(true)
    mob:setUntargetable(true)
    mob:SetAutoAttackEnabled(false)
    mob:SetMobAbilityEnabled(false)
    mob:setStatus(xi.status.INVISIBLE)

    hideDuration = hideDuration or 500

    if hideDuration < 500 then
        hideDuration = 500
    end

    mob:timer(hideDuration, function(mobArg)
        mobArg:hideName(false)
        mobArg:setUntargetable(false)
        mobArg:SetAutoAttackEnabled(true)
        mobArg:SetMobAbilityEnabled(true)

        if mobArg:isDead() then
            return
        end

        mobArg:setStatus(xi.status.UPDATE)
    end)
end

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.NO_DROPS, 1)
    mob:setMobMod(xi.mobMod.ALLI_HATE, 30)
    mob:addListener("WEAPONSKILL_STATE_ENTER", "PRUDENCE_MIMIC_START", function(mobArg, skillID)
        local prudenceIDs = { 16912846, 16912847 }
        if mobArg:getLocalVar('[JoP]mimic') ~= 1 and mobArg:isAlive() then
            for _, jailer in ipairs(prudenceIDs) do
                if mobArg:getID() ~= jailer then
                    local prudence_mimic = GetMobByID(jailer)
                    if
                        prudence_mimic:isAlive() and
                        mobArg:canUseAbilities() and
                        prudence_mimic:getLocalVar('[JoP]LastAbilityMimic') + 6 < os.time() and
                        mobArg:checkDistance(prudence_mimic) <= 10
                    then
                        prudence_mimic:setLocalVar('[JoP]mimic', 1)
                        prudence_mimic:setLocalVar('[JoP]LastAbilityMimic', os.time())
                        prudence_mimic:useMobAbility(skillID)
                    end
                end
            end
        end
    end)

    mob:addListener("WEAPONSKILL_STATE_EXIT", "PRUDENCE_MIMIC_STOP", function(mobArg, skillID)
        mobArg:setLocalVar('[JoP]mimic', 0)
    end)
end

entity.onMobSpawn = function(mob)
    mob:setAnimationSub(6) -- Mouth closed
    mob:addStatusEffectEx(xi.effect.FLEE, 0, 100, 0, 60)
    mob:setMod(xi.mod.TRIPLE_ATTACK, 20)
    mob:setMod(xi.mod.REGEN, 10)
end

entity.onMobFight = function(mob)
    if
        mob:checkDistance(mob:getTarget()) >= 12 and
        mob:canUseAbilities()
    then
        teleport(mob, 1000)
    end

    local perfectDodgeHPP =
    {
        95, 85, 75, 65, 55, 45, 35, 25, 15, 5,
    }

    local perfectDodgeTrigger = mob:getLocalVar("perfectDodgeTrigger")
    local perfectDodgeQueue = mob:getLocalVar("perfectDodgeQueue")
    local mobHPP = mob:getHPP()
    for trigger, hpp in ipairs(perfectDodgeHPP) do
        if mobHPP < hpp and perfectDodgeTrigger < trigger then
            mob:setLocalVar("perfectDodgeTrigger", trigger)
            mob:setLocalVar("perfectDodgeQueue", perfectDodgeQueue + 1)
            break
        end
    end

    if
        mob:actionQueueEmpty() == true and
        mob:canUseAbilities()
    then
        perfectDodgeQueue = mob:getLocalVar("perfectDodgeQueue")
        if perfectDodgeQueue > 0 then
            perfectDodgeQueue = mob:getLocalVar("perfectDodgeQueue") - 1
            if not mob:hasStatusEffect(xi.effect.PERFECT_DODGE) and mob:isAlive() then
                mob:useMobAbility(693)
                mob:setLocalVar("perfectDodgeQueue", perfectDodgeQueue)
            end
        end
    end
end

entity.onMobDisengage = function(mob, target)
end

entity.onMobDeath = function(mob, player, isKiller)
end

entity.onMobDespawn = function(mob)
    local firstPrudence     = GetMobByID(ID.mob.JAILER_OF_PRUDENCE_1)
    local secondPrudence    = GetMobByID(ID.mob.JAILER_OF_PRUDENCE_2)
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
