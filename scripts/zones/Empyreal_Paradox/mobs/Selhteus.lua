-----------------------------------
-- Area: Empyreal Paradox
--  Mob: Selh'teus
-- Chains of Promathia 8-4 BCNM Fight
-----------------------------------
local ID = zones[xi.zone.EMPYREAL_PARADOX]
mixins = { require('scripts/mixins/helper_npc') }
-----------------------------------
---@type TMobEntity
local entity = {}

-- Circular grid coordinates for each arena for Selhteus to navigate
local pathNodes =
{
    [1] =
    {
        -- Center
        { x = -520.0000, y = -120.0000, z = 521.8342 },

        -- Inner ring
        { x = -520.0000, y = -120.0000, z = 529.8342 },
        { x = -505.6569, y = -120.0000, z = 537.3912 },
        { x = -520.0000, y = -120.0000, z = 545.8342 },
        { x = -534.3431, y = -120.0000, z = 537.3912 },
        { x = -520.0000, y = -120.0000, z = 513.8342 },
        { x = -505.6569, y = -120.0000, z = 506.2772 },
        { x = -534.3431, y = -120.0000, z = 506.2772 },

        -- Middle ring
        { x = -520.0000, y = -120.0000, z = 537.8342 },
        { x = -510.2426, y = -120.0000, z = 540.7912 },
        { x = -500.4852, y = -120.0000, z = 538.0912 },
        { x = -491.9140, y = -120.0000, z = 532.3582 },
        { x = -495.6889, y = -120.0000, z = 520.0472 },
        { x = -491.9140, y = -120.0000, z = 511.3102 },
        { x = -500.4852, y = -120.0000, z = 505.5772 },
        { x = -510.2426, y = -120.0000, z = 502.8772 },
        { x = -520.0000, y = -120.0000, z = 505.8342 },
        { x = -529.7574, y = -120.0000, z = 502.8772 },
        { x = -539.5148, y = -120.0000, z = 505.5772 },
        { x = -548.0860, y = -120.0000, z = 511.3102 },
        { x = -543.8796, y = -120.0000, z = 521.7178 },
        { x = -548.0860, y = -120.0000, z = 532.3582 },
        { x = -539.5148, y = -120.0000, z = 538.0912 },
        { x = -529.7574, y = -120.0000, z = 540.7912 },

        -- Outer ring
        { x = -520.0000, y = -120.0000, z = 545.8342 },
        { x = -508.5410, y = -120.0000, z = 542.6254 },
        { x = -500.0000, y = -120.0000, z = 535.4736 },
        { x = -493.4590, y = -120.0000, z = 525.5430 },
        { x = -495.6889, y = -120.0000, z = 520.0472 },
        { x = -493.4590, y = -120.0000, z = 518.1254 },
        { x = -500.0000, y = -120.0000, z = 508.1948 },
        { x = -508.5410, y = -120.0000, z = 501.0430 },
        { x = -520.0000, y = -120.0000, z = 497.8342 },
        { x = -531.4590, y = -120.0000, z = 501.0430 },
        { x = -540.0000, y = -120.0000, z = 508.1948 },
        { x = -546.5410, y = -120.0000, z = 518.1254 },
        { x = -543.8796, y = -120.0000, z = 521.7178 },
        { x = -546.5410, y = -120.0000, z = 525.5430 },
        { x = -540.0000, y = -120.0000, z = 535.4736 },
        { x = -531.4590, y = -120.0000, z = 542.6254 },
    },

    [2] =
    {
        -- Center
        { x = 520.1450, y = 0.0000, z = 517.1620 },

        -- Inner ring
        { x = 520.1450, y = 0.0000, z = 525.1620 },
        { x = 505.8019, y = 0.0000, z = 532.7190 },
        { x = 520.1450, y = 0.0000, z = 541.1620 },
        { x = 534.4881, y = 0.0000, z = 532.7190 },
        { x = 520.1450, y = 0.0000, z = 509.1620 },
        { x = 505.8019, y = 0.0000, z = 501.6050 },
        { x = 534.4881, y = 0.0000, z = 501.6050 },

        -- Middle ring
        { x = 519.5360, y = 0.0000, z = 545.3560 },
        { x = 509.7786, y = 0.0000, z = 542.1472 },
        { x = 500.0212, y = 0.0000, z = 537.1100 },
        { x = 491.4500, y = 0.0000, z = 529.7050 },
        { x = 544.9990, y = 0.0000, z = 519.6650 },
        { x = 491.4500, y = 0.0000, z = 511.1650 },
        { x = 500.0212, y = 0.0000, z = 497.1140 },
        { x = 509.7786, y = 0.0000, z = 492.0768 },
        { x = 520.2430, y = 0.0000, z = 493.1810 },
        { x = 530.5074, y = 0.0000, z = 492.1940 },
        { x = 539.2688, y = 0.0000, z = 497.1140 },
        { x = 548.6400, y = 0.0000, z = 509.3390 },
        { x = 494.1020, y = 0.0000, z = 520.4900 },
        { x = 548.6400, y = 0.0000, z = 529.7050 },
        { x = 539.2688, y = 0.0000, z = 537.1100 },
        { x = 530.5074, y = 0.0000, z = 542.1472 },

        -- Outer ring
        { x = 519.5360, y = 0.0000, z = 545.3560 },
        { x = 508.0770, y = 0.0000, z = 542.1472 },
        { x = 499.5290, y = 0.0000, z = 535.0054 },
        { x = 492.9880, y = 0.0000, z = 525.0748 },
        { x = 544.9990, y = 0.0000, z = 519.6650 },
        { x = 492.9880, y = 0.0000, z = 513.2492 },
        { x = 499.5290, y = 0.0000, z = 503.3186 },
        { x = 508.0770, y = 0.0000, z = 496.1768 },
        { x = 520.2430, y = 0.0000, z = 493.1810 },
        { x = 531.9130, y = 0.0000, z = 496.1768 },
        { x = 540.4610, y = 0.0000, z = 503.3186 },
        { x = 547.0020, y = 0.0000, z = 513.2492 },
        { x = 494.1020, y = 0.0000, z = 520.4900 },
        { x = 547.0020, y = 0.0000, z = 525.0748 },
        { x = 540.4610, y = 0.0000, z = 535.0054 },
        { x = 531.9130, y = 0.0000, z = 542.1472 },
    },

    [3] =
    {
        -- Center
        { x = -519.5570, y = 120.0000, z = -516.6000 },

        -- Inner ring
        { x = -519.5570, y = 120.0000, z = -508.6000 },
        { x = -505.2139, y = 120.0000, z = -501.0430 },
        { x = -519.5570, y = 120.0000, z = -491.1600 },
        { x = -533.9001, y = 120.0000, z = -501.0430 },
        { x = -519.5570, y = 120.0000, z = -524.6000 },
        { x = -505.2139, y = 120.0000, z = -532.1570 },
        { x = -533.9001, y = 120.0000, z = -532.1570 },

        -- Middle ring
        { x = -519.9580, y = 120.0000, z = -495.6430 },
        { x = -510.2006, y = 120.0000, z = -498.6000 },
        { x = -500.4432, y = 120.0000, z = -504.4330 },
        { x = -491.8720, y = 120.0000, z = -514.1660 },
        { x = -493.6080, y = 120.0000, z = -519.8430 },
        { x = -491.8720, y = 120.0000, z = -527.8800 },
        { x = -500.4432, y = 120.0000, z = -537.0130 },
        { x = -510.2006, y = 120.0000, z = -539.5030 },
        { x = -519.9030, y = 120.0000, z = -545.4980 },
        { x = -529.6604, y = 120.0000, z = -539.5030 },
        { x = -539.4178, y = 120.0000, z = -537.0130 },
        { x = -547.9890, y = 120.0000, z = -527.8800 },
        { x = -544.8860, y = 120.0000, z = -520.8420 },
        { x = -547.9890, y = 120.0000, z = -514.1660 },
        { x = -539.4178, y = 120.0000, z = -504.4330 },
        { x = -529.6604, y = 120.0000, z = -498.6000 },

        -- Outer ring
        { x = -519.9580, y = 120.0000, z = -495.6430 },
        { x = -508.4990, y = 120.0000, z = -498.8518 },
        { x = -499.9510, y = 120.0000, z = -505.9936 },
        { x = -493.4100, y = 120.0000, z = -516.0242 },
        { x = -493.6080, y = 120.0000, z = -519.8430 },
        { x = -493.4100, y = 120.0000, z = -527.7618 },
        { x = -499.9510, y = 120.0000, z = -537.7924 },
        { x = -508.4990, y = 120.0000, z = -544.9342 },
        { x = -519.9030, y = 120.0000, z = -545.4980 },
        { x = -531.3070, y = 120.0000, z = -544.9342 },
        { x = -539.8550, y = 120.0000, z = -537.7924 },
        { x = -546.3960, y = 120.0000, z = -527.7618 },
        { x = -544.8860, y = 120.0000, z = -520.8420 },
        { x = -546.3960, y = 120.0000, z = -516.0242 },
        { x = -539.8550, y = 120.0000, z = -505.9936 },
        { x = -531.3070, y = 120.0000, z = -498.8518 },
    },
}

-- Helper NPC configuration
local helperConfig =
{
    targetMobs = function(mob)
        local battlefieldArea = mob:getBattlefield():getArea()
        local areaOffset = (battlefieldArea - 1) * 2
        return
        {
            ID.mob.PROMATHIA + areaOffset,     -- Promathia
            ID.mob.PROMATHIA + areaOffset + 1, -- Promathia v2
        }
    end,
}

-- Function to navigate Selhteus to the closest node at least 16' from Promathia
local findClosestNode = function(mob, target, area)
    local closestNode = nil
    local minDist     = 0

    for _, node in ipairs(pathNodes[area]) do
        local distFromProm = utils.distance(target:getPos(), node)
        local distFromMob  = utils.distance(mob:getPos(), node)

        if distFromProm >= 16 then
            if distFromMob < minDist or minDist == 0 then
                minDist = distFromMob
                closestNode = node
            end
        end
    end

    if closestNode then
        mob:pathTo(closestNode.x, closestNode.y, closestNode.z)
    end
end

entity.onMobInitialize = function(mob)
    mob:setBehavior(bit.bor(mob:getBehavior(), xi.behavior.NO_ASSIST)) -- Disallow spells cast on Selhteus
    mob:addMod(xi.mod.CURE_POTENCY_RCVD, -100)
    mob:setMobMod(xi.mobMod.NO_REST, 1)
    mob:setAutoAttackEnabled(false)
end

entity.onMobSpawn = function(mob)
    xi.mix.helperNpc.config(mob, helperConfig)
    mob:setMobAbilityEnabled(false)

    mob:addListener('WEAPONSKILL_STATE_ENTER', 'SELH_SKILL_MSG', function(mobArg, skillID)
        if skillID == xi.mobSkill.LUMINOUS_LANCE_1 then
            mobArg:messageText(mobArg, ID.text.SELHTEUS_TEXT + 1)
        elseif skillID == xi.mobSkill.REJUVENATION_1 then
            mobArg:messageText(mobArg, ID.text.SELHTEUS_TEXT + 2)
        end
    end)
end

entity.onMobEngage = function(mob, target)
    mob:setMod(xi.mod.REGAIN, 50)
    mob:setLocalVar('positionTimer', GetSystemTime() + 30)
    mob:setLocalVar('lanceTime', GetSystemTime() + 90)
end

entity.onMobFight = function(mob, target)
    local battlefield = mob:getBattlefield()
    if not battlefield then
        return
    end

    if xi.combat.behavior.isEntityBusy(mob) then
        return
    end

    -- Ensures he is at least 16' from Promathia
    local positionTimer = mob:getLocalVar('positionTimer')
    local area          = battlefield:getArea()
    if
        mob:checkDistance(target) < 15 and
        positionTimer < GetSystemTime()
    then
        findClosestNode(mob, target, area)
        mob:setLocalVar('positionTimer', GetSystemTime() + 30)
    end

    -- Uses Rejuvenation when below 10% HP in 2nd phase
    local phase      = battlefield:getLocalVar('phase')
    local hasRejuved = mob:getLocalVar('rejuv') == 1
    if
        mob:getHPP() < 10 and
        not hasRejuved and
        phase == 1
    then
        mob:useMobAbility(xi.mobSkill.REJUVENATION_1)
        mob:setLocalVar('rejuv', 1)
    end

    -- Lance is ready, animate summoning lance and allow Luminous Lance usage
    local lanceReady = mob:getLocalVar('lanceReady')
    if lanceReady == 0 then
        local lanceTime = mob:getLocalVar('lanceTime')
        if lanceTime <= GetSystemTime() then
            mob:setLocalVar('lanceReady', 1)
            mob:entityAnimationPacket(xi.animationString.SPECIAL_00)
            mob:setMobAbilityEnabled(false)
            mob:timer(3000, function(selhteus)
                selhteus:setLocalVar('lanceReady', 2)
            end)
        end
    end

    -- If lance is ready, and target is not busy, use Luminous Lance and allow Revelation usage
    if
        lanceReady == 2 and
        target:getAnimationSub() == 0 and
        not xi.combat.behavior.isEntityBusy(target)
    then
        mob:useMobAbility(xi.mobSkill.LUMINOUS_LANCE_1)
        mob:setLocalVar('lanceTime', GetSystemTime() + 90)
        mob:setLocalVar('lanceReady', 0)
        mob:timer(3000, function(selhteus)
            mob:entityAnimationPacket('ids0')
            mob:setMobAbilityEnabled(true)
        end)
    end

    -- Uses TP if above 1000
    if phase == 2 and mob:getTP() >= 1000 then
        mob:useMobAbility()
    end
end

entity.onMobMobskillChoose = function(mob, target)
    return xi.mobSkill.REVELATION_1
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        mob:messageText(mob, ID.text.SELHTEUS_TEXT)
        mob:getBattlefield():lose()
    end
end

entity.onMobDespawn = function(mob)
    mob:removeListener('SELH_SKILL_MSG')
end

return entity
