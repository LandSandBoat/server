-----------------------------------
-- Area: Monarch Linn
--  Mob: Ouryu
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

local hpToNextPhase = 1000
local initialPhaseDuration = 60
local subsequentPhaseDuration = 120
local initialGroundPhaseAnimationSub = 0
local allFlightPhaseAnimationSub = 1
local subsequentGroundPhaseAnimationSub = 2

local function setNextPhaseTriggers(mob, phaseDuration)
    local battleTime = 0
    if mob:isEngaged() then
        battleTime = mob:getBattleTime()
    end

    mob:setLocalVar('nextPhaseTime', battleTime + phaseDuration)
    mob:setLocalVar('nextPhaseHP', math.max(mob:getHP() - hpToNextPhase, 0))
end

local function fly(mob)
    mob:setAnimationSub(allFlightPhaseAnimationSub)
    mob:addStatusEffectEx(xi.effect.ALL_MISS, 0, 1, 0, 0)
    mob:setMobSkillAttack(731)
    setNextPhaseTriggers(mob, subsequentPhaseDuration)
end

local function landWithoutTouchdown(mob)
    mob:setAnimationSub(subsequentGroundPhaseAnimationSub)
    mob:delStatusEffect(xi.effect.ALL_MISS)
    mob:setMobSkillAttack(0)
    setNextPhaseTriggers(mob, subsequentPhaseDuration)
    -- need to still show the touchdown animation (as per capture)
    mob:injectActionPacket(mob:getID(), 11, 974, 0, 0x18, 0, 0, 0)
    -- always set this no matter how ouryu lands to avoid any issues
    mob:setLocalVar('mistmeltUsed', 0)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    -- resetting so it doesn't respawn in flight mode
    mob:setMobSkillAttack(0)
    -- subanim 0 is only used when it spawns until first flight
    mob:setAnimationSub(initialGroundPhaseAnimationSub)
    if mob:hasStatusEffect(xi.effect.ALL_MISS) then
        mob:delStatusEffect(xi.effect.ALL_MISS)
    end

    -- 54 + 2 + 14 = 70 total damage (the 14 dmg accounts for a 25% boost)
    mob:setMobMod(xi.mobMod.WEAPON_BONUS, 14)
    mob:setMod(xi.mod.UDMGRANGE, -3500)
    mob:setMod(xi.mod.UDMGMAGIC, -3500)
    mob:addImmunity(xi.immunity.SLOW)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.STUN)
    mob:addImmunity(xi.immunity.PLAGUE)
    mob:setMod(xi.mod.UFASTCAST, 50)
    mob:setMobMod(xi.mobMod.SIGHT_RANGE, 20)

    -- can use invincible on ground or air
    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            { id = xi.jsa.INVINCIBLE, hpp = math.random(50, 85) },
        },
    })

    -- set on spawn as the first damage can occur already before onMobEngage
    setNextPhaseTriggers(mob, initialPhaseDuration)
end

entity.onMobEngage = function(mob, target)
    -- track if already engaged once so can set the the correct phase duration if roams
    if mob:getLocalVar('alreadyEngagedOnce') == 0 then
        mob:setLocalVar('alreadyEngagedOnce', 1)
    end
end

entity.onMobRoam = function(mob)
    -- if already engaged once then keep setting phase triggers
    -- since damage can occur even before onMobEngage
    if mob:getLocalVar('alreadyEngagedOnce') == 1 then
        setNextPhaseTriggers(mob, subsequentPhaseDuration)
    end
end

entity.onMobFight = function(mob, target)
    local bf = mob:getBattlefield()
    if
        bf and
        bf:getID() == 961 and
        mob:getHPP() < 30
    then
        bf:win()
        return
    end

    if
        mob:actionQueueEmpty() and
        mob:canUseAbilities()
    then
        local nextPhaseTime = mob:getLocalVar('nextPhaseTime')
        local nextPhaseHP = mob:getLocalVar('nextPhaseHP')
        local mistmeltUsed = mob:getLocalVar('mistmeltUsed')

        -- valid conditions for a change
        if
            mob:getBattleTime() > nextPhaseTime or
            mob:getHP() < nextPhaseHP
        then
            -- subanimation 0 is the initial on ground animation, so check if should fly
            if mob:getAnimationSub() == initialGroundPhaseAnimationSub then
                fly(mob)
            -- subanimation 1 is flying animation, so check if should land
            elseif mob:getAnimationSub() == allFlightPhaseAnimationSub then
                -- use touchdown mobskill
                -- touchdown script changes the animation sub, miss status, and mob skill attack
                mob:useMobAbility(1302)
            -- subanimation 2 is on ground animation, so check if should fly
            elseif  mob:getAnimationSub() == subsequentGroundPhaseAnimationSub then
                fly(mob)
            end
        elseif
            mistmeltUsed == 1 and
            mob:getAnimationSub() == allFlightPhaseAnimationSub
        then
            landWithoutTouchdown(mob)
        end
    end

    -- Wakeup from sleep immediately if flying
    if mob:getAnimationSub() == allFlightPhaseAnimationSub then
        mob:wakeUp()
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)
    -- only reset change vars if actually perform touchdown mobskill
    if skill:getID() == 1302 then
        setNextPhaseTriggers(mob, subsequentPhaseDuration)
        -- always set this no matter how ouryu lands to avoid any issues
        mob:setLocalVar('mistmeltUsed', 0)
    end
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ENSTONE, { chance = 15 })
end

entity.onMobDisengage = function(mob)
    landWithoutTouchdown(mob)
end

return entity
