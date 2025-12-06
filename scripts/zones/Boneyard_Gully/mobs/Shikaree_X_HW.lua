-----------------------------------
-- Area: Boneyard_Gully
--  Mob: Shikaree X (Head Wind)
-- BCNM: Head Wind
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
local ID = zones[xi.zone.BONEYARD_GULLY]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.DUAL_WIELD, 1)
    mob:setMod(xi.mod.DARK_SLEEP_RES_RANK, 8)
    mob:setMod(xi.mod.LIGHT_SLEEP_RES_RANK, 8)
    mob:setMod(xi.mod.BIND_RES_RANK, 8)
    -- TODO: Needs gravity res rank
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.SPECIAL_SKILL, 0)
    mob:setMobMod(xi.mobMod.WEAPON_BONUS, 30)
    mob:setMod(xi.mod.REGAIN, 55)
    mob:setMobAbilityEnabled(false)
    xi.mob.callPets(mob, mob:getID() + 2, { inactiveTime = 3000 })
end

entity.onMobFight = function(mob, target)
    -- Handle "Blackened Siredon" timer and effect.
    local siredonTimer = mob:getLocalVar('siredonTimer')
    if siredonTimer > 0 and GetSystemTime() >= siredonTimer then
        mob:setLocalVar('siredonTimer', 0)
        mob:setMod(xi.mod.REGAIN, 55)
    end

    if xi.combat.behavior.isEntityBusy(mob) then
        return
    end

    local battlefield = mob:getBattlefield()
    if not battlefield then
        return
    end

    -- Lock target during skillchain execution (scState 2=STARTING, 3=EXECUTING)
    local scState = battlefield:getLocalVar('scState')
    if scState == 2 or scState == 3 then
        local scLeaderID = battlefield:getLocalVar('scLeader')
        local scLeader = scLeaderID > 0 and GetMobByID(scLeaderID) or nil
        if scLeader and scLeader:isAlive() then
            local leaderTarget = scLeader:getTarget()
            if leaderTarget and leaderTarget:getID() ~= target:getID() then
                mob:updateEnmity(leaderTarget)
            end
        end

    -- Shikaree use TP at 1000 when solo
    elseif scState == 4 and mob:getTP() >= 1000 then
        mob:useMobAbility()
    end

    -- Handle pet respawn
    local petTimer = mob:getLocalVar('petTimer')
    if
        GetSystemTime() >= petTimer and
        not GetMobByID(mob:getID() + 2):isSpawned()
    then
        xi.mob.callPets(mob, mob:getID() + 2, { inactiveTime = 3000 })
    end
end

entity.onMobMobskillChoose = function(mob, target)
    local tpMoves =
    {
        xi.mobSkill.DANCING_EDGE,
        xi.mobSkill.EVISCERATION,
        xi.mobSkill.SHADOWSTITCH,
        xi.mobSkill.SHARK_BITE,
    }

    return tpMoves[math.random(1, #tpMoves)]
end

entity.onMobWeaponSkill = function(target, mob, skill)
    local skillID     = skill:getID()
    local battlefield = mob:getBattlefield()

    -- Solo skill message when only one Shikaree is alive (scState 4 = SOLO)
    if battlefield and battlefield:getLocalVar('scState') == 4 then
        mob:messageText(mob, ID.text.SHIKAREE_X_OFFSET + 4)
    end

    -- 2-Hour message.
    if skillID == xi.mobSkill.FAMILIAR_1 then
        mob:messageText(mob, ID.text.SHIKAREE_X_2HR)
    end

    -- Handle skillchain progression
    local scSkill  = mob:getLocalVar('scSkill')
    local scNextID = mob:getLocalVar('scNextID')

    if skillID == scSkill then
        -- Transition from STARTING to EXECUTING when leader's skill fires
        if battlefield and battlefield:getLocalVar('scState') == 2 then
            battlefield:setLocalVar('scState', 3)
        end

        -- Pull message for either starting SC or using skill mid SC
        local scMessage = mob:getLocalVar('scMessage')
        if scMessage > 0 then
            mob:messageText(mob, scMessage)
        end

        -- Clear this mob's skill tracking
        mob:setLocalVar('scSkill', 0)
        mob:setLocalVar('scPendingTime', 0)

        -- Trigger next mob in chain
        if scNextID > 0 then
            local nextMob = GetMobByID(scNextID)
            if nextMob and nextMob:isAlive() then
                nextMob:setLocalVar('scPendingTime', GetSystemTime() + 3)
            end
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
    mob:messageText(mob, ID.text.SHIKAREE_X_OFFSET)
end

return entity
