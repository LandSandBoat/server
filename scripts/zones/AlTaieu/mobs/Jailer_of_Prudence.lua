-----------------------------------
-- Area: Al'Taieu
--   NM: Jailer of Prudence
-- AnimationSubs: 0 - Normal, 3 - Mouth Open
-----------------------------------
local ID = require("scripts/zones/AlTaieu/IDs")
mixins = { require("scripts/mixins/job_special") }
require("scripts/globals/roe")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.NO_DROPS, 1)
    mob:setMobMod(xi.mobMod.ALLI_HATE, 30)
    mob:addListener("WEAPONSKILL_STATE_ENTER", "PRUDENCE_MIMIC_START", function(mobArg, skillID)
        local prudenceIDs = { ID.mob.JAILER_OF_PRUDENCE_1, ID.mob.JAILER_OF_PRUDENCE_2 }
        if mobArg:getLocalVar('[JoP]mimic') ~= 1 and mobArg:isAlive() then
            for _, jailer in ipairs(prudenceIDs) do
                if mobArg:getID() ~= jailer then
                    local prudenceMimic = GetMobByID(jailer)
                    if
                        prudenceMimic:isAlive() and
                        mobArg:canUseAbilities() and
                        prudenceMimic:getLocalVar('[JoP]LastAbilityMimic') + 6 < os.time() and
                        mobArg:checkDistance(prudenceMimic) <= 10
                    then
                        prudenceMimic:setLocalVar('[JoP]mimic', 1)
                        prudenceMimic:setLocalVar('[JoP]LastAbilityMimic', os.time())
                        prudenceMimic:useMobAbility(skillID)
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
    mob:setMod(xi.mod.ATT, 332)
    mob:setMod(xi.mod.DEF, 415)
    mob:setMod(xi.mod.EVA, 413)
end

entity.onMobFight = function(mob)
    if
        mob:checkDistance(mob:getTarget()) >= 12 and
        mob:canUseAbilities()
    then
        local target = mob:getTarget()
        mob:teleport(target:getPos(), target)
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
        mob:actionQueueEmpty() and
        mob:canUseAbilities()
    then
        perfectDodgeQueue = mob:getLocalVar("perfectDodgeQueue")
        if perfectDodgeQueue > 0 then
            perfectDodgeQueue = mob:getLocalVar("perfectDodgeQueue") - 1
            if not mob:hasStatusEffect(xi.effect.PERFECT_DODGE) and mob:isAlive() then
                mob:useMobAbility(693)
                mob:addStatusEffectEx(xi.effect.FLEE, 0, 100, 0, 30)
                mob:setLocalVar("perfectDodgeQueue", perfectDodgeQueue)
            end
        end
    end
end

entity.onMobDisengage = function(mob, target)
end

entity.onMobDeath = function(mob, player, optParams)
    local firstPrudence  = GetMobByID(ID.mob.JAILER_OF_PRUDENCE_1)
    local secondPrudence = GetMobByID(ID.mob.JAILER_OF_PRUDENCE_2)
    local count          = player:getLocalVar("prudenceCount")

    if firstPrudence or secondPrudence then
        player:setLocalVar("prudenceCount", count + 1)
    end

    if count >= 2 and player:hasEminenceRecord(770) then
        xi.roe.onRecordTrigger(player, 770)
        player:setLocalVar("prudenceCount", 0)
    end
end

entity.onMobDespawn = function(mob)
    local firstPrudence  = GetMobByID(ID.mob.JAILER_OF_PRUDENCE_1)
    local secondPrudence = GetMobByID(ID.mob.JAILER_OF_PRUDENCE_2)

    if mob:getID() == ID.mob.JAILER_OF_PRUDENCE_1 then
        secondPrudence:setMobMod(xi.mobMod.NO_DROPS, 0)
        secondPrudence:setAnimationSub(3) -- Mouth Open
        -- 100% triple attack
        secondPrudence:setMod(xi.mod.TRIPLE_ATTACK, 100)
        -- Boost all damage taken by 50%
        secondPrudence:setMod(xi.mod.UDMGPHYS, 5000)
        secondPrudence:setMod(xi.mod.UDMGRANGE, 5000)
        secondPrudence:setMod(xi.mod.UDMGMAGIC, 5000)
        secondPrudence:setMod(xi.mod.UDMGBREATH, 5000)
    else
        firstPrudence:setMobMod(xi.mobMod.NO_DROPS, 0)
        firstPrudence:setAnimationSub(3) -- Mouth Open
        -- 100% triple attack
        firstPrudence:setMod(xi.mod.TRIPLE_ATTACK, 100)
        -- Boost all damage taken by 50%
        firstPrudence:setMod(xi.mod.UDMGPHYS, 5000)
        firstPrudence:setMod(xi.mod.UDMGRANGE, 5000)
        firstPrudence:setMod(xi.mod.UDMGMAGIC, 5000)
        firstPrudence:setMod(xi.mod.UDMGBREATH, 5000)
    end
end

return entity
