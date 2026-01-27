-----------------------------------
-- Area: Waughroon Shrine
--  Mob: Platoon Scorpion
-- BCNM: Operation Desert Swarm
-----------------------------------
local ID = zones[xi.zone.WAUGHROON_SHRINE]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.PETRIFY)
end

entity.onMobSpawn = function(mob)
    mob:setAutoAttackEnabled(true)
    mob:setMobMod(xi.mobMod.NO_MOVE, 0)

    local battlefield = mob:getBattlefield()
    if not battlefield then
        return
    end

    battlefield:setLocalVar('baseId', ID.mob.PLATOON_SCORPION + (battlefield:getArea() - 1) * 6)
end

entity.onMobFight = function(mob)
    local battlefield = mob:getBattlefield()

    if not battlefield then
        return
    end

    -- If we are disabled from using a skill, check if it's expired.
    local isDisabled = mob:getLocalVar('isDisabled')
    if
        isDisabled ~= 0 and
        GetSystemTime() >= mob:getLocalVar('disableEnd')
    then
        mob:setAutoAttackEnabled(true)
        mob:setMobMod(xi.mobMod.NO_MOVE, 0)
        mob:setLocalVar('isDisabled', 0)
        mob:setLocalVar('disableEnd', 0)
    end

    -- If mimic is not active, return.
    if battlefield:getLocalVar('mimicActive') == 0 then
        return
    end

    -- Get the mimic round, the leader of that round and the skill they used.
    local mimicRound  = battlefield:getLocalVar('mimicRound')
    local mimicLeader = battlefield:getLocalVar('mimicLeader')
    local mimicSkill  = battlefield:getLocalVar('mimicSkill')

    -- If we are the leader or we have already completed the mimic round, return.
    if
        mob:getID() == mimicLeader or
        mob:getLocalVar('mimicRound') == mimicRound
    then
        return
    end

    -- If we are out of TP or busy, skip this mimic round. Otherwise, use the skill.
    if
        mob:getTP() < 1000 or
        xi.combat.behavior.isEntityBusy(mob)
    then
        mob:setLocalVar('mimicRound', mimicRound)
    else
        mob:setLocalVar('mimicRound', mimicRound)
        mob:useMobAbility(mimicSkill)
    end

    -- Check if all scorpions have finished the mimic round, if not, return.
    local baseId = battlefield:getLocalVar('baseId')

    for i = 0, 5 do
        local scorpion = GetMobByID(baseId + i)

        if
            scorpion and
            scorpion:isAlive() and
            scorpion:getID() ~= mimicLeader and
            scorpion:getLocalVar('mimicRound') ~= mimicRound
        then
            return
        end
    end

    -- If we have made it here, all scorpions have finished the mimic round, reset the variables for the next one.
    battlefield:setLocalVar('mimicActive', 0)
    battlefield:setLocalVar('mimicLeader', 0)
end

entity.onMobWeaponSkill = function(target, mob, skill)
    local battlefield = mob:getBattlefield()

    if not battlefield then
        return
    end

    -- Store the skill we are using
    local skillId = skill:getID()

    -- Apply debuff based on skill used and record the time we used it - play flavor text with a 3 second delay to allow skill to finish.
    if skillId == xi.mobSkill.WILD_RAGE then
        mob:setAutoAttackEnabled(false)
        mob:setLocalVar('disableEnd', GetSystemTime() + math.random(10, 25))
        mob:setLocalVar('isDisabled', 1)
        mob:timer(3000, function(mobArg)
            mobArg:messageText(mobArg, ID.text.SCORPION_IS_STUNNED, false)
        end)

    elseif skillId == xi.mobSkill.EARTH_POUNDER then
        mob:setMobMod(xi.mobMod.NO_MOVE, 1)
        mob:setLocalVar('disableEnd', GetSystemTime() + math.random(10, 25))
        mob:setLocalVar('isDisabled', 1)
        mob:timer(3000, function(mobArg)
            mobArg:messageText(mobArg, ID.text.SCORPION_IS_BOUND, false)
        end)
    end

    -- If mimic is active, nothing to do here
    if battlefield:getLocalVar('mimicActive') == 1 then
        return
    end

    -- If we make it here, we are the leader of a new mimic round, set it up!
    local nextRound = battlefield:getLocalVar('mimicRound') + 1

    battlefield:setLocalVar('mimicActive', 1)
    battlefield:setLocalVar('mimicSkill', skillId)
    battlefield:setLocalVar('mimicLeader', mob:getID())
    battlefield:setLocalVar('mimicRound', nextRound)

    mob:setLocalVar('mimicRound', nextRound)
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        local battlefield = mob:getBattlefield()

        if battlefield then
            local scorpionsDefeated = battlefield:getLocalVar('scorpionsDefeated')
            battlefield:setLocalVar('scorpionsDefeated', scorpionsDefeated + 1)
        end
    end
end

return entity
