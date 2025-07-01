-----------------------------------
-- Flying Wyrms family mixin
-- Jormungand, Ouryu, Tiamat, etc...
-----------------------------------
require('scripts/globals/mixins')
-----------------------------------
g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

local param =
{
    SKILL_REGULAR_ATTACK = 1,
    SKILL_TOUCHDOWN      = 2,
    THRESHOLD_TIME       = 3,
    THRESHOLD_HP         = 4,
    FORCED_GROUND        = 5,
}

    -- NOTE: For the Ouryu in "The savage II" be sure to name it diferently than just "Ouryu" in SQL
local mobData =
{
    ['Tiamat'            ] = { 730, xi.mobSkill.TOUCHDOWN_TIAMAT,     120, 10000, false }, -- NM: Attohwa Chasm
    ['Ouryu_Ouryu_Cometh'] = { 731, xi.mobSkill.TOUCHDOWN_OURYU,      120,  6000, true  }, -- BCNM: Ouryu cometh.
    ['Ouryu_The_Savage'  ] = { 731, xi.mobSkill.TOUCHDOWN_OURYU,      120,  1000, true  }, -- BCNM: The Savage.
    ['Jormungand'        ] = { 732, xi.mobSkill.TOUCHDOWN_JORMUNGAND,  30,  6000, false }, -- NM: Uleguerand Range
}

local function isBusy(mob)
    if
        not mob:actionQueueEmpty() or
        not mob:canUseAbilities() or
        mob:hasStatusEffect(xi.effect.SLEEP_I) or
        mob:hasStatusEffect(xi.effect.PETRIFICATION) or
        mob:hasStatusEffect(xi.effect.TERROR) or
        mob:hasStatusEffect(xi.effect.BLOOD_WEAPON) or
        mob:hasStatusEffect(xi.effect.MIGHTY_STRIKES)
    then
        return true
    end

    return false
end

local function handlePhaseVariables(mob)
    local data          = mobData[mob:getName()]
    local timeThreshold = data and data[param.THRESHOLD_TIME] or 120
    local hpThreshold   = data and data[param.THRESHOLD_HP] or 6000
    local battleTime    = mob:isEngaged() and mob:getBattleTime() or 0

    mob:setLocalVar('nextPhaseTime', battleTime + timeThreshold)
    mob:setLocalVar('nextPhaseHP', mob:getHP() - hpThreshold)
end

local function handleFlying(mob)
    local regularAttack = mobData[mob:getName()][param.SKILL_REGULAR_ATTACK] or 730 -- Note: This is a skill list, not an skill ID.

    mob:setAnimationSub(1)
    mob:addStatusEffectEx(xi.effect.ALL_MISS, 0, 1, 0, 0)
    mob:setMobSkillAttack(regularAttack)
    handlePhaseVariables(mob)
end

local function handleLanding(mob)
    mob:setAnimationSub(2)
    mob:delStatusEffect(xi.effect.ALL_MISS)
    mob:setMobSkillAttack(0)
    mob:setLocalVar('mistmeltUsed', 0)
    handlePhaseVariables(mob)
end

g_mixins.families.flyingWyrm = function(flyingWyrmMob)
    -- On mob spawn.
    flyingWyrmMob:addListener('SPAWN', 'FLYING_WYRM_SPAWN', function(mob)
        -- Set grounded status
        mob:setAnimationSub(0)
        mob:setMobSkillAttack(0)
        mob:delStatusEffect(xi.effect.ALL_MISS)
        mob:setMobMod(xi.mobMod.NO_MOVE, 0)
        mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
        mob:setBehavior(bit.bor(mob:getBehavior(), xi.behavior.NO_TURN))
    end)

    -- On mob engage.
    flyingWyrmMob:addListener('ENGAGE', 'FLYING_WYRM_ENGAGE', function(mob, target)
        handlePhaseVariables(mob)
    end)

    -- On mob fight
    flyingWyrmMob:addListener('COMBAT_TICK', 'FLYING_WYRM_COMBAT_TICK', function(mob)
        -- Wake up from sleep immediately if flying.
        local mobAnimationSub = mob:getAnimationSub()
        if mobAnimationSub == 1 then
            mob:wakeUp()
        end

        -- If mob isn't busy.
        if not isBusy(mob) then
            local data          = mobData[mob:getName()]
            local canBeGrounded = data and data[param.FORCED_GROUND] or false -- Does Mistmelt work?
            local nextPhaseTime = mob:getLocalVar('nextPhaseTime')
            local nextPhaseHP   = mob:getLocalVar('nextPhaseHP')

            -- Force phase change (Fly->Ground)
            if
                canBeGrounded and
                mobAnimationSub == 1 and
                mob:getLocalVar('mistmeltUsed') == 1
            then
                mob:injectActionPacket(mob:getID(), 11, 974, 0, 0x18, 0, 0, 0) -- Show touchdown animation.
                handleLanding(mob) -- Handles animationSub, modifiers and timers.

            -- Natural phase change.
            elseif
                (nextPhaseTime > 0 and nextPhaseTime < mob:getBattleTime()) or -- Check if enough time (in fight) has passed.
                (nextPhaseHP > 0 and nextPhaseHP >= mob:getHP())               -- Check if enough HP has been taken from the mob.
            then
                -- Grounded
                if mobAnimationSub ~= 1 then
                    handleFlying(mob)

                -- Flying
                else
                    local touchdown = data and data[param.SKILL_TOUCHDOWN] or xi.mobSkill.TOUCHDOWN_1
                    mob:useMobAbility(touchdown)
                end
            end
        end
    end)

    flyingWyrmMob:addListener('WEAPONSKILL_USE', 'FLYING_WYRM_WEAPONSKILL_USE', function(mob, target, skillId, tp, action)
        local data      = mobData[mob:getName()]
        local touchdown = data and data[param.SKILL_TOUCHDOWN] or xi.mobSkill.TOUCHDOWN_1
        if skillId == touchdown then
            handleLanding(mob) -- Handles animationSub, modifiers and timers.
        end
    end)

    -- On mob disengage.
    flyingWyrmMob:addListener('DISENGAGE', 'FLYING_WYRM_DISENGAGE', function(mob)
        -- If flying, force landing.
        if mob:getAnimationSub() == 1 then
            mob:injectActionPacket(mob:getID(), 11, 974, 0, 0x18, 0, 0, 0) -- Show touchdown animation.
            handleLanding(mob) -- Handles animationSub, modifiers and timers.
        end
    end)
end

return g_mixins.families.flyingWyrm
