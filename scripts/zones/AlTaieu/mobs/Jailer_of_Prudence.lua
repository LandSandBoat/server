-----------------------------------
-- Area: Al'Taieu
--   NM: Jailer of Prudence
-- AnimationSubs: 0 - Normal, 3 - Mouth Open
-----------------------------------
local ID = zones[xi.zone.ALTAIEU]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.NO_DROPS, 1)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
    mob:addImmunity(xi.immunity.PARALYZE)
    mob:addImmunity(xi.immunity.BLIND)
    mob:addImmunity(xi.immunity.POISON)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.STUN)
    mob:addImmunity(xi.immunity.SLOW)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)

    mob:addListener('WEAPONSKILL_BEFORE_USE', 'JOP_WS_MIRROR', function(mobArg, skillid)
        if mobArg:getLocalVar('mirrored_ws') == 1 then
            mobArg:setLocalVar('mirrored_ws', 0)
            return
        end

        local prudenceId = ID.mob.JAILER_OF_PRUDENCE
        local otherPrudence = mobArg:getID() == prudenceId and GetMobByID(prudenceId + 1) or GetMobByID(prudenceId)

        if
            otherPrudence and
            otherPrudence:isAlive() and
            otherPrudence:checkDistance(mob) <= 50 and
            skillid ~= xi.jsa.PERFECT_DODGE -- Perfect Dodge is manually controlled
        then
            otherPrudence:setLocalVar('mirrored_ws', 1)
            otherPrudence:useMobAbility(skillid)
        end
    end)
end

entity.onMobSpawn = function(mob)
    mob:setAnimationSub(0) -- Mouth closed
    mob:setMod(xi.mod.TRIPLE_ATTACK, 20)
    mob:addMod(xi.mod.DEFP, 33)
    mob:addMod(xi.mod.MOVE_SPEED_STACKABLE, 20)
    mob:addMobMod(xi.mobMod.WEAPON_BONUS, 72) -- 180 total weapon damage
end

local teleportToTarget = function(mob, target, currentTargetId)
    mob:setMobMod(xi.mobMod.NO_MOVE, 1)
    mob:timer(500, function(mobArg)
        if not mobArg then
            return
        end

        local targetX, targetY, targetZ = target:getXPos(), target:getYPos(), target:getZPos()
        local offsetX = math.random(-2, 2)
        local offsetZ = math.random(-2, 2)
        mobArg:setStatus(xi.status.INVISIBLE)
        mobArg:setPos(targetX + offsetX, targetY, targetZ + offsetZ, target:getRotPos())

        mobArg:timer(500, function(mobArg2)
            if not mobArg2 then
                return
            end

            mobArg2:setStatus(xi.status.UPDATE)
            mobArg2:setMobMod(xi.mobMod.NO_MOVE, 0)
        end)
    end)
end

entity.onMobFight = function(mob, target)
    -- Manual Perfect Dodge control to sync up usage between both Prudences
    local currentTime = GetSystemTime()
    local prudenceId = ID.mob.JAILER_OF_PRUDENCE
    local otherPrudence = mob:getID() == prudenceId and GetMobByID(prudenceId + 1) or GetMobByID(prudenceId)

    local hasUsedPerfectDodge = mob:getLocalVar('perfectDodgeUsed') == 1
    local cooldownTime = mob:getLocalVar('perfectDodgeCooldown')

    if
        (not hasUsedPerfectDodge and mob:getHPP() <= 95) or
        (hasUsedPerfectDodge and currentTime >= cooldownTime)
    then
        mob:useMobAbility(xi.jsa.PERFECT_DODGE)
        mob:setLocalVar('perfectDodgeCooldown', currentTime + 120)

        -- First time only: trigger both Prudences together
        if not hasUsedPerfectDodge then
            mob:setLocalVar('perfectDodgeUsed', 1)

            if otherPrudence and otherPrudence:isAlive() then
                otherPrudence:useMobAbility(xi.jsa.PERFECT_DODGE)
                otherPrudence:setLocalVar('perfectDodgeUsed', 1)
                otherPrudence:setLocalVar('perfectDodgeCooldown', currentTime + 120)
            end
        end
    end

    -- Track target changes and teleport logic during Perfect Dodge
    if target and mob:hasStatusEffect(xi.effect.PERFECT_DODGE) then
        local previousTarget = mob:getLocalVar('previousTarget')
        local currentTargetId = target:getID()
        local targetSwitched = currentTargetId ~= previousTarget and currentTargetId > 0

        if targetSwitched then
            if
                mob:checkDistance(target) > mob:getMeleeRange(target)
            then
                teleportToTarget(mob, target, currentTargetId)
            end

            mob:setLocalVar('previousTarget', currentTargetId)
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
    local count = player:getLocalVar('prudenceCount')
    local mobId = mob:getID()
    local prudenceId = ID.mob.JAILER_OF_PRUDENCE

    if
        mobId == prudenceId or
        mobId == prudenceId + 1
    then
        player:setLocalVar('prudenceCount', count + 1)
    end

    if count >= 2 and player:hasEminenceRecord(770) then
        xi.roe.onRecordTrigger(player, 770)
        player:setLocalVar('prudenceCount', 0)
    end

    if optParams.isKiller or optParams.noKiller then
        local targetMobId = mobId == prudenceId and prudenceId + 1 or prudenceId
        local targetPrudence = GetMobByID(targetMobId)

        if targetPrudence then
            targetPrudence:setMobMod(xi.mobMod.NO_DROPS, 0)
            targetPrudence:setAnimationSub(3) -- Mouth Open
            targetPrudence:setMod(xi.mod.TRIPLE_ATTACK, 100)
            targetPrudence:addMod(xi.mod.ATTP, 100)
            targetPrudence:delMod(xi.mod.DEFP, -50)
        end
    end
end

return entity
