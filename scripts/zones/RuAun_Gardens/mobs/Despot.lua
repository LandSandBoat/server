-----------------------------------
-- Area: RuAun Gardens
--   NM: Despot
-----------------------------------
local ID = zones[xi.zone.RUAUN_GARDENS]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -0.100, y = -42.000, z = -291.000 }
}

entity.phList =
{
    [ID.mob.DESPOT - 16] = ID.mob.DESPOT,
    [ID.mob.DESPOT - 15] = ID.mob.DESPOT,
    [ID.mob.DESPOT - 14] = ID.mob.DESPOT,
    [ID.mob.DESPOT - 13] = ID.mob.DESPOT,
    [ID.mob.DESPOT - 12] = ID.mob.DESPOT,
    [ID.mob.DESPOT - 11] = ID.mob.DESPOT,
    [ID.mob.DESPOT - 10] = ID.mob.DESPOT,
    [ID.mob.DESPOT - 9 ] = ID.mob.DESPOT,
    [ID.mob.DESPOT - 8 ] = ID.mob.DESPOT,
    [ID.mob.DESPOT - 7 ] = ID.mob.DESPOT,
    [ID.mob.DESPOT - 6 ] = ID.mob.DESPOT,
    [ID.mob.DESPOT - 5 ] = ID.mob.DESPOT,
    [ID.mob.DESPOT - 4 ] = ID.mob.DESPOT,
    [ID.mob.DESPOT - 3 ] = ID.mob.DESPOT,
    [ID.mob.DESPOT - 2 ] = ID.mob.DESPOT,
    [ID.mob.DESPOT - 1 ] = ID.mob.DESPOT,
}

entity.onMobInitialize = function(mob)
    mob:setBaseSpeed(40)
    mob:setMobMod(xi.mobMod.RUN_SPEED_MULT, 250)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
    mob:setMobMod(xi.mobMod.GIL_MIN, 18000)
    mob:setMobMod(xi.mobMod.GIL_MAX, 18000)
    mob:setMobMod(xi.mobMod.MUG_GIL, 3250)
    -- TODO: Check Petrify immunity, other Sky NMs seem to have it.
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.ELEGY)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.SLOW)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.PLAGUE)

    mob:addListener('WEAPONSKILL_STATE_EXIT', 'PH_VAR', function(mobArg, skillId, wasExecuted)
        -- Despot rapidly uses several Panzerfaust in a row
        local counter  = mob:getLocalVar('panzerfaustCounter')
        local maxCount = mob:getLocalVar('panzerfaustMax')

        if wasExecuted then
            counter = counter + 1
            mob:setLocalVar('panzerfaustCounter', counter)
        end

        -- Continue sequence. An out-of-range use is dropped by the engine; onMobFight resumes the chain.
        local target = mob:getTarget()
        if
            target and
            target:isAlive() and
            counter < maxCount
        then
            mob:useMobAbility(xi.mobSkill.PANZERFAUST, target, 1)

        -- Break sequence.
        else
            mob:setAutoAttackEnabled(true)
            mob:setLocalVar('panzerfaustCounter', 0)
            mob:setLocalVar('panzerfaustMax', 0)
        end
    end)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)

    -- Ensure default state.
    mob:setAutoAttackEnabled(true)
    mob:setLocalVar('panzerfaustCounter', 0)
    mob:setLocalVar('panzerfaustMax', 0)

    -- Early return: No zone object.
    local zone = mob:getZone()
    if not zone then
        return
    end

    -- Early return: No placeholder ID.
    local ph = GetMobByID(zone:getLocalVar('DespotPlaceholderID'))
    if not ph then
        return
    end

    -- Handle position.
    local pos = ph:getPos()
    mob:setPos(pos.x, pos.y, pos.z, pos.r)

    -- Handle enmity/claim.
    local killerId = ph:getLocalVar('killer')
    if killerId == 0 then
        return
    end

    local killer = GetPlayerByID(killerId)
    if not killer then
        return
    end

    if
        not killer:isEngaged() and
        killer:checkDistance(mob) <= 50
    then
        mob:updateClaim(killer)
    end
end

entity.onMobFight = function(mob, target)
    if xi.combat.behavior.isEntityBusy(mob) then
        return
    end

    -- Resume a Panzerfaust chain the target outranged, once the chase closes back within range.
    if
        mob:getLocalVar('panzerfaustMax') > 0 and
        mob:checkDistance(target) <= mob:getAbilityDistance(xi.mobSkill.PANZERFAUST)
    then
        mob:useMobAbility(xi.mobSkill.PANZERFAUST, target, 1)
    end
end

entity.onMobMobskillChoose = function(mob, target)
    local maxCount = mob:getLocalVar('panzerfaustMax')

    -- Initialize sequence.
    if maxCount == 0 then
        mob:setAutoAttackEnabled(false)
        mob:setLocalVar('panzerfaustMax', math.randomInt(2, 5))
    end

    return xi.mobSkill.PANZERFAUST
end

entity.onMobWeaponSkill = function(mob, target, skill, action)
    skill:setAnimationTime(0)
end

entity.onMobDisengage = function(mob)
    -- Drop any unfinished sequence so it does not leak into the next fight.
    mob:setAutoAttackEnabled(true)
    mob:setLocalVar('panzerfaustCounter', 0)
    mob:setLocalVar('panzerfaustMax', 0)
end

return entity
