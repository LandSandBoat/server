-----------------------------------
-- Global version of onMobDeath
-----------------------------------
require('scripts/globals/magic')
require('scripts/globals/missions')
require('scripts/globals/quests')
-----------------------------------
xi = xi or {}
xi.mob = xi.mob or {}

-- onMobDeathEx is called from the core
xi.mob.onMobDeathEx = function(mob, player, isKiller, isWeaponSkillKill)
end

-----------------------------------
-- placeholder / lottery NMs
-----------------------------------

-- is a lottery NM already spawned or primed to pop?
local function lotteryPrimed(phList)
    local nm

    for k, v in pairs(phList) do
        nm = GetMobByID(v)
        if nm ~= nil and (nm:isSpawned() or nm:getRespawnTime() ~= 0) then
            return true
        end
    end

    return false
end

local getMobLuaPathObject = function(mob)
    if not mob then
        return nil
    end

    return xi.zones[mob:getZoneName()].mobs[mob:getName()]
end

-- - mobParam can either be a mobid or a mob entity object
-- it either accepts a table of spawn points to randomize, or looks to the mob's cached lua object for a spawnPoints entry
---@param mobParam number|CBaseEntity?
---@param spawnPointsOverride table?
xi.mob.updateNMSpawnPoint = function(mobParam, spawnPointsOverride)
    local origMobParam = mobParam
    -- sometimes we call from Zone.lua files and only have the mob id
    if type(mobParam) == 'number' then
        mobParam = GetMobByID(mobParam)
    end

    if mobParam == nil then
        print('[updateNMSpawnPoint] Invalid mob parameter:')
        print(origMobParam)

        return
    end

    -- if no spawnPoints table was sent, extract from mob lua object
    local spawnPoints = spawnPointsOverride
    if spawnPoints == nil then
        local mobObject = getMobLuaPathObject(mobParam)
        if mobObject and mobObject.spawnPoints then
            spawnPoints = mobObject.spawnPoints
        end
    end

    -- Special check for NMs with the same name but multiple IDs
    if spawnPoints and spawnPoints[mobParam:getID()] then
        spawnPoints = spawnPoints[mobParam:getID()]
    end

    if
        spawnPoints ~= nil and
        type(spawnPoints) == 'table' and
        #spawnPoints > 0
    then
        local chosenSpawn    = utils.randomEntry(spawnPoints)
        local randomRotation = math.random(0, 255) -- rotation does not matter

        -- Updates the mob's spawn point
        mobParam:setSpawn(chosenSpawn.x, chosenSpawn.y, chosenSpawn.z, randomRotation)
    end
end

-- potential lottery placeholder was killed
---@param ph CBaseEntity
---@param phNmId integer
---@param chance integer
---@param cooldown integer
---@param params table?
xi.mob.phOnDespawn = function(ph, phNmId, chance, cooldown, params)
    params = params or {}
    --[[
        params.immediate          = true    pop NM without waiting for next PH pop time
        params.dayOnly            = true    spawn NM only at day time
        params.nightOnly          = true    spawn NM only at night time
        params.noPosUpdate        = true    do not run xi.mob.updateNMSpawnPoint()
        params.spawnPoints        = { {x = , y = , z = } } table of spawn points to choose from, overrides NM's lua-defined table
        params.doNotEnablePhSpawn = true    Don't enable ph respawns after NM is killed (for chained ph systems like steelfleece)
    ]]

    local phId = ph:getID()
    local nmId = nil
    local nm = nil
    local phList = nil
    local mobEntityObj = getMobLuaPathObject(GetMobByID(phNmId))
    if mobEntityObj then
        phList = mobEntityObj.phList
        nmId   = phList and phList[phId]
        nm     = nmId and GetMobByID(nmId)
    end

    -- This was not a PH for the NM
    if
        type(nmId) ~= 'number' or
        nm == nil or
        phList == nil
    then
        return false
    end

    -- ensure certain boolean params exist
    local paramKeys =
    {
        'immediate',
        'dayOnly',
        'nightOnly',
        'noPosUpdate',
        'doNotEnablePhSpawn',
    }

    for _, pKey in ipairs(paramKeys) do
        if type(params[pKey]) ~= 'boolean' then
            params[pKey] = false
        end
    end

    if xi.settings.main.NM_LOTTERY_CHANCE then
        chance = xi.settings.main.NM_LOTTERY_CHANCE >= 0 and (chance * xi.settings.main.NM_LOTTERY_CHANCE) or 100
    end

    if xi.settings.main.NM_LOTTERY_COOLDOWN then
        cooldown = xi.settings.main.NM_LOTTERY_COOLDOWN >= 0 and (cooldown * xi.settings.main.NM_LOTTERY_COOLDOWN) or cooldown
    end

    local pop = nm:getLocalVar('pop')

    chance = math.ceil(chance * 10) -- chance / 1000.

    if
        GetSystemTime() <= pop or
        lotteryPrimed(phList) or
        math.random(1, 1000) > chance
    then
        return false
    end

    local nextRepopTime = VanadielTime() + GetMobRespawnTime(phId)
    local nextRepopHour = math.floor((nextRepopTime % xi.vanaTime.DAY) / xi.vanaTime.HOUR)
    -- If the NM is day only and spawn would happen during the night, bail out
    if
        params.dayOnly and
        nextRepopHour < 4 and
        nextRepopHour >= 20
    then
        return false
    -- If the NM is night only and spawn would happen during the day, bail out
    elseif
        params.nightOnly and
        nextRepopHour >= 4 and
        nextRepopHour < 20
    then
        return false
    end

    -- on PH death, replace PH repop with NM repop
    DisallowRespawn(phId, true)
    DisallowRespawn(nmId, false)

    -- Update mob's spawn position, if available
    if not params.noPosUpdate then
        xi.mob.updateNMSpawnPoint(nm, params.spawnPoints or nil)
    end

    -- if params.immediate is true, spawn the nm params.immediately (1ms) else use placeholder's timer
    nm:setRespawnTime(params.immediate and 1 or GetMobRespawnTime(phId))

    nm:addListener('DESPAWN', 'DESPAWN_' .. nmId, function(m)
        -- on NM death, replace NM repop with PH repop
        DisallowRespawn(nmId, true)
        if not params.doNotEnablePhSpawn then
            DisallowRespawn(phId, false)
            local phMob = GetMobByID(phId)
            if phMob then
                phMob:setRespawnTime(GetMobRespawnTime(phId))
            end
        end

        if m:getLocalVar('doNotInvokeCooldown') == 0 then
            m:setLocalVar('pop', GetSystemTime() + cooldown)
        end

        m:removeListener('DESPAWN_' .. nmId)
    end)

    return true
end

-----------------------------------
-- Mob skills
-----------------------------------
xi.mob.skills =
{
    RECOIL_DIVE = 641,
    CYTOKINESIS = 2514,
    DISSOLVE = 2550,
}

-----------------------------------
-- mob additional melee effects
-----------------------------------

xi.mob.additionalEffect =
{
    BLIND      = 0,
    CURSE      = 1,
    ENAERO     = 2,
    ENBLIZZARD = 3,
    ENDARK     = 4,
    ENFIRE     = 5,
    ENLIGHT    = 6,
    ENSTONE    = 7,
    ENTHUNDER  = 8,
    ENWATER    = 9,
    EVA_DOWN   = 10,
    HP_DRAIN   = 11,
    MP_DRAIN   = 12,
    PARALYZE   = 13,
    PETRIFY    = 14,
    PLAGUE     = 15,
    POISON     = 16,
    SILENCE    = 17,
    SLOW       = 18,
    STUN       = 19,
    TERROR     = 20,
    TP_DRAIN   = 21,
    WEIGHT     = 22,
    ENAMNESIA  = 23,
    DISPEL     = 24,
    BIND       = 25,
    SLEEP      = 26,
}
xi.mob.ae = xi.mob.additionalEffect

local additionalEffects =
{
    [xi.mob.ae.BLIND] =
    {
        chance = 25,
        ele         = xi.element.DARK,
        sub         = xi.subEffect.BLIND,
        msg         = xi.msg.basic.ADD_EFFECT_STATUS,
        applyEffect = true,
        eff         = xi.effect.BLINDNESS,
        power       = 20,
        duration    = 30,
        minDuration = 1,
        maxDuration = 45,
    },

    [xi.mob.ae.CURSE] =
    {
        chance      = 20,
        ele         = xi.element.DARK,
        sub         = xi.subEffect.CURSE,
        msg         = xi.msg.basic.ADD_EFFECT_STATUS,
        applyEffect = true,
        eff         = xi.effect.CURSE_I,
        power       = 50,
        duration    = 300,
        minDuration = 1,
        maxDuration = 300,
    },

    [xi.mob.ae.ENAERO] =
    {
        ele                = xi.element.WIND,
        sub                = xi.subEffect.WIND_DAMAGE,
        msg                = xi.msg.basic.ADD_EFFECT_DMG,
        negMsg             = xi.msg.basic.ADD_EFFECT_HEAL,
        mod                = xi.mod.INT,
        bonusAbilityParams = { bonusmab = 0, includemab = false },
    },

    [xi.mob.ae.ENBLIZZARD] =
    {
        ele                = xi.element.ICE,
        sub                = xi.subEffect.ICE_DAMAGE,
        msg                = xi.msg.basic.ADD_EFFECT_DMG,
        negMsg             = xi.msg.basic.ADD_EFFECT_HEAL,
        mod                = xi.mod.INT,
        bonusAbilityParams = { bonusmab = 0, includemab = false },
    },

    [xi.mob.ae.ENDARK] =
    {
        ele                = xi.element.DARK,
        sub                = xi.subEffect.DARKNESS_DAMAGE,
        msg                = xi.msg.basic.ADD_EFFECT_DMG,
        negMsg             = xi.msg.basic.ADD_EFFECT_HEAL,
        mod                = xi.mod.INT,
        bonusAbilityParams = { bonusmab = 0, includemab = false },
    },

    [xi.mob.ae.ENFIRE] =
    {
        ele                = xi.element.FIRE,
        sub                = xi.subEffect.FIRE_DAMAGE,
        msg                = xi.msg.basic.ADD_EFFECT_DMG,
        negMsg             = xi.msg.basic.ADD_EFFECT_HEAL,
        mod                = xi.mod.INT,
        bonusAbilityParams = { bonusmab = 0, includemab = false },
    },

    [xi.mob.ae.ENLIGHT] =
    {
        ele                = xi.element.LIGHT,
        sub                = xi.subEffect.LIGHT_DAMAGE,
        msg                = xi.msg.basic.ADD_EFFECT_DMG,
        negMsg             = xi.msg.basic.ADD_EFFECT_HEAL,
        mod                = xi.mod.INT,
        bonusAbilityParams = { bonusmab = 0, includemab = false },
    },

    [xi.mob.ae.ENSTONE] =
    {
        ele                = xi.element.EARTH,
        sub                = xi.subEffect.EARTH_DAMAGE,
        msg                = xi.msg.basic.ADD_EFFECT_DMG,
        negMsg             = xi.msg.basic.ADD_EFFECT_HEAL,
        mod                = xi.mod.INT,
        bonusAbilityParams = { bonusmab = 0, includemab = false },
    },

    [xi.mob.ae.ENTHUNDER] =
    {
        ele                = xi.element.THUNDER,
        sub                = xi.subEffect.LIGHTNING_DAMAGE,
        msg                = xi.msg.basic.ADD_EFFECT_DMG,
        negMsg             = xi.msg.basic.ADD_EFFECT_HEAL,
        mod                = xi.mod.INT,
        bonusAbilityParams = { bonusmab = 0, includemab = false },
    },

    [xi.mob.ae.ENWATER] =
    {
        ele                = xi.element.WATER,
        sub                = xi.subEffect.WATER_DAMAGE,
        msg                = xi.msg.basic.ADD_EFFECT_DMG,
        negMsg             = xi.msg.basic.ADD_EFFECT_HEAL,
        mod                = xi.mod.INT,
        bonusAbilityParams = { bonusmab = 0, includemab = false },
    },

    [xi.mob.ae.EVA_DOWN] =
    {
        chance      = 25,
        ele         = xi.element.ICE,
        sub         = xi.subEffect.EVASION_DOWN,
        msg         = xi.msg.basic.ADD_EFFECT_STATUS,
        applyEffect = true,
        eff         = xi.effect.EVASION_DOWN,
        power       = 25,
        duration    = 30,
        minDuration = 1,
        maxDuration = 60,
    },

    [xi.mob.ae.HP_DRAIN] =
    {
        chance             = 10,
        ele                = xi.element.DARK,
        sub                = xi.subEffect.HP_DRAIN,
        msg                = xi.msg.basic.ADD_EFFECT_HP_DRAIN,
        mod                = xi.mod.INT,
        bonusAbilityParams = { bonusmab = 0, includemab = false },
        code               = function(mob, target, power)
            mob:addHP(power)
        end,
    },

    [xi.mob.ae.MP_DRAIN] =
    {
        chance             = 10,
        ele                = xi.element.DARK,
        sub                = xi.subEffect.MP_DRAIN,
        msg                = xi.msg.basic.ADD_EFFECT_MP_DRAIN,
        mod                = xi.mod.INT,
        bonusAbilityParams = { bonusmab = 0, includemab = false },
        code               = function(mob, target, power)
            local mp = math.min(power, target:getMP())
            target:delMP(mp)
            mob:addMP(mp)
        end,
    },

    [xi.mob.ae.PARALYZE] =
    {
        chance      = 25,
        ele         = xi.element.ICE,
        sub         = xi.subEffect.PARALYSIS,
        msg         = xi.msg.basic.ADD_EFFECT_STATUS,
        applyEffect = true,
        eff         = xi.effect.PARALYSIS,
        power       = 20,
        duration    = 30,
        minDuration = 1,
        maxDuration = 60,
    },

    [xi.mob.ae.PETRIFY] =
    {
        chance      = 20,
        ele         = xi.element.EARTH,
        sub         = xi.subEffect.PETRIFY,
        msg         = xi.msg.basic.ADD_EFFECT_STATUS,
        applyEffect = true,
        eff         = xi.effect.PETRIFICATION,
        power       = 1,
        duration    = 30,
        minDuration = 1,
        maxDuration = 45,
    },

    [xi.mob.ae.PLAGUE] =
    {
        chance      = 25,
        ele         = xi.element.WATER,
        sub         = xi.subEffect.PLAGUE,
        msg         = xi.msg.basic.ADD_EFFECT_STATUS,
        applyEffect = true,
        eff         = xi.effect.PLAGUE,
        power       = 1,
        duration    = 60,
        minDuration = 1,
        maxDuration = 60,
    },

    [xi.mob.ae.POISON] =
    {
        chance      = 25,
        ele         = xi.element.WATER,
        sub         = xi.subEffect.POISON,
        msg         = xi.msg.basic.ADD_EFFECT_STATUS,
        applyEffect = true,
        eff         = xi.effect.POISON,
        power       = 1,
        duration    = 30,
        minDuration = 1,
        maxDuration = 30,
        tick        = 3,
    },

    [xi.mob.ae.SILENCE] =
    {
        chance      = 25,
        ele         = xi.element.WIND,
        sub         = xi.subEffect.SILENCE,
        msg         = xi.msg.basic.ADD_EFFECT_STATUS,
        applyEffect = true,
        eff         = xi.effect.SILENCE,
        power       = 1,
        duration    = 30,
        minDuration = 1,
        maxDuration = 30,
    },

    [xi.mob.ae.ENAMNESIA] =
    {
        chance      = 25,
        ele         = xi.element.FIRE,
        sub         = xi.subEffect.AMNESIA,
        msg         = xi.msg.basic.ADD_EFFECT_STATUS,
        applyEffect = true,
        eff         = xi.effect.AMNESIA,
        power       = 1,
        duration    = 30,
        minDuration = 1,
        maxDuration = 30,
    },

    [xi.mob.ae.SLEEP] =
    {
        chance      = 25,
        ele         = xi.element.DARK,
        sub         = xi.subEffect.SLEEP,
        msg         = xi.msg.basic.ADD_EFFECT_STATUS,
        applyEffect = true,
        eff         = xi.effect.SLEEP_I,
        power       = 20,
        duration    = 30,
        minDuration = 1,
        maxDuration = 45,
    },

    [xi.mob.ae.SLOW] =
    {
        chance      = 25,
        ele         = xi.element.EARTH,
        sub         = xi.subEffect.DEFENSE_DOWN,
        msg         = xi.msg.basic.ADD_EFFECT_STATUS,
        applyEffect = true,
        eff         = xi.effect.SLOW,
        power       = 1000,
        duration    = 30,
        minDuration = 1,
        maxDuration = 45,
    },

    [xi.mob.ae.STUN] =
    {
        chance      = 20,
        ele         = xi.element.THUNDER,
        sub         = xi.subEffect.STUN,
        msg         = xi.msg.basic.ADD_EFFECT_STATUS,
        applyEffect = true,
        eff         = xi.effect.STUN,
        duration    = 5,
    },

    [xi.mob.ae.TERROR] =
    {
        chance = 20,
        sub         = xi.subEffect.PARALYSIS,
        msg         = xi.msg.basic.ADD_EFFECT_STATUS,
        applyEffect = true,
        eff         = xi.effect.TERROR,
        duration    = 5,
        code        = function(mob, target, power)
            mob:resetEnmity(target)
        end,
    },

    [xi.mob.ae.TP_DRAIN] =
    {
        chance             = 25,
        ele                = xi.element.DARK,
        sub                = xi.subEffect.TP_DRAIN,
        msg                = xi.msg.basic.ADD_EFFECT_TP_DRAIN,
        mod                = xi.mod.INT,
        bonusAbilityParams = { bonusmab = 0, includemab = false },
        code               = function(mob, target, power)
            local tp = math.min(power, target:getTP())
            target:delTP(tp)
            mob:addTP(tp)
        end,
    },

    [xi.mob.ae.WEIGHT] =
    {
        chance      = 25,
        ele         = xi.element.WIND,
        sub         = xi.subEffect.BLIND, -- TODO
        msg         = xi.msg.basic.ADD_EFFECT_STATUS,
        applyEffect = true,
        eff         = xi.effect.WEIGHT,
        power       = 1,
        duration    = 30,
        minDuration = 1,
        maxDuration = 45,
    },

    [xi.mob.ae.DISPEL] =
    {
        chance      = 25,
        ele         = xi.element.DARK,
        sub         = xi.subEffect.DISPEL,
        msg         = xi.msg.basic.ADD_EFFECT_DISPEL,
        applyEffect = false,
        power       = 1,
    },

    [xi.mob.ae.BIND] =
    {
        chance      = 10,
        ele         = xi.element.ICE,
        sub         = xi.subEffect.DISPEL, -- TODO
        msg         = xi.msg.basic.ADD_EFFECT_STATUS,
        applyEffect = true,
        eff         = xi.effect.BIND,
        power       = 1,
        duration    = 30,
        minDuration = 1,
        maxDuration = 90,
    },
}

--[[
    Helper function for xi.mob.onAddEffect that applies a status effect.
--]]
local addEffectStatus = function(mob, target, ae, params)
    local resist = 1

    if ae.ele then
        resist = applyResistanceAddEffect(mob, target, ae.ele, ae.eff)
    end

    if resist > 0.5 and not target:hasStatusEffect(ae.eff) then
        local power    = params.power or ae.power or 0
        local tick     = ae.tick or 0
        local duration = params.duration or ae.duration

        duration = utils.clamp(duration, ae.minDuration, ae.maxDuration) * resist

        target:addStatusEffect(ae.eff, power, tick, duration)

        if params.code then
            params.code(mob, target, power)
        elseif ae.code then
            ae.code(mob, target, power)
        end

        return ae.sub, ae.msg, ae.eff
    end

    return 0, 0, 0
end

--[[
    Helper function for xi.mob.onAddEffect that dispels an effect.
--]]
local addEffectDispel = function(target, ae)
    local dispelledEffect = target:dispelStatusEffect(xi.effectFlag.DISPELABLE)

    if dispelledEffect == xi.effect.NONE then
        return 0, 0, 0
    end

    return ae.sub, ae.msg, dispelledEffect
end

--[[
    Helper function for xi.mob.onAddEffect that applies damage.
--]]
local addEffectImmediate = function(mob, target, damage, ae, params)
    local power = 0

    if params.power then
        power = params.power
    elseif ae.mod then
        local dMod = mob:getStat(ae.mod) - target:getStat(ae.mod)

        if dMod > 20 then
            dMod = 20 + (dMod - 20) / 2
        end

        -- This is a bad assumption, but it prevents some negative damage (healing) when there otherwise shouldn't be
        -- TODO: better understand damage add effects from mobs
        if dMod < 0 then
            dMod = 0
        end

        power = dMod + target:getMainLvl() - mob:getMainLvl() + damage / 2
    end

    -- target:printToPlayer(string.format('Initial Power: %f', power)) -- DEBUG

    power = addBonusesAbility(mob, ae.ele, target, power, ae.bonusAbilityParams)
    power = power * applyResistanceAddEffect(mob, target, ae.ele, 0)
    power = power * xi.spells.damage.calculateAbsorption(target, ae.ele, true)
    power = power * xi.spells.damage.calculateNullification(target, ae.ele, true, false)

    if ae.sub ~= xi.subEffect.TP_DRAIN and ae.sub ~= xi.subEffect.MP_DRAIN then
        power = finalMagicNonSpellAdjustments(mob, target, ae.ele, power)
    end

    -- target:printToPlayer(string.format('Adjusted Power: %f', power)) -- DEBUG

    local message = ae.msg
    if power < 0 then
        if ae.negMsg then
            message = ae.negMsg
            power   = power * -1 -- outgoing action packets only support unsigned integers. The "negative message" will also handle healing automagically deep inside core somewhere.
        else
            power = 0
        end
    end

    if power ~= 0 then
        if params.code then
            params.code(mob, target, power)
        elseif ae.code then
            ae.code(mob, target, power)
        end

        return ae.sub, message, power
    end

    return 0, 0, 0
end

--[[
    mob, target, and damage are passed from core into mob script's onAdditionalEffect
    effect should be of type xi.mob.additionalEffect (see above)
    params is a table that can contain any of:
        chance: percent chance that effect procs on hit (default 20)
        power: power of effect
        duration: duration of effect, in seconds
        code: additional code that will run when effect procs, of form function(mob, target, power)
    params will override effect's default settings
--]]
xi.mob.onAddEffect = function(mob, target, damage, effect, params)
    if type(params) ~= 'table' then
        params = {}
    end

    local ae = additionalEffects[effect]

    if ae then
        local chance = params.chance or ae.chance or 100
        local dLevel = target:getMainLvl() - mob:getMainLvl()

        if dLevel > 0 then
            chance = chance - 5 * dLevel
            chance = utils.clamp(chance, 5, 95)
        end

        -- target:printToPlayer(string.format('Chance: %i', chance)) -- DEBUG

        if math.random(1, 100) <= chance then

            -- STATUS EFFECT
            if ae.applyEffect then
                return addEffectStatus(mob, target, ae, params)

            -- DISPEL
            elseif effect == xi.mob.ae.DISPEL and target then
                return addEffectDispel(target, ae)

            -- IMMEDIATE EFFECT
            else
                return addEffectImmediate(mob, target, damage, ae, params)
            end
        end
    else
        printf('invalid additional effect for mobId %i', mob:getID())
    end

    return 0, 0, 0
end

-----------------------------------
-- mob difficulty enums for checkDifficulty()
-----------------------------------

xi.mob.difficulty =
{
    TOO_WEAK             = 0,
    INCREDIBLY_EASY_PREY = 1,
    EASY_PREY            = 2,
    DECENT_CHALLENGE     = 3,
    EVEN_MATCH           = 4,
    TOUGH                = 5,
    VERY_TOUGH           = 6,
    INCREDIBLY_TOUGH     = 7,
    MAX                  = 8,
}
xi.mob.diff = xi.mob.difficulty

-----------------------------------
-- Centralized function for calling one or more mob "pets"
-- It may be helpful to think of mobs with multiple as having "helpers" rather than explicitly pets
-- Since this is a looser definition than an explicit `->PMaster` and `->PPet` relationship that exists:
-- - these "pets" can have real pets of their own
-- - mobs can have multiple "pets"
-- - if the petId maps to the mob's actual pet (or petIds is nil and the mob has a pet mapped),
--      then no ROAM listener is installed on the pet, but the animations can still be consistently managed in one place
-----------------------------------

xi.mob.callPets = function(mob, petIds, params)
    params = params or {}
    -- params table:
    --      params.dieWithOwner: will kill pets immediately if owner dies
    --      params.superLink:    mob will assist pet (pet will always assist mob)
    --      params.maxSpawns:    stop if this many pets get spawned
    --      params.ignoreBusy:   allow pets to get summoned even if owner is busy, interupting any action it was performing
    --      params.noAnimation:  no animation packet from owner when calling pet
    --      params.inactiveTime: how long for the call pet to take (owner will be inactive during period)
    --          this implies using summoner start/stop entity animation packet (which most mobs use when calling either pets or additional helpers)
    -- if inactiveTime is zero, the following will determine an action packet to signal the mob is calling a pet
    --      params.callPetJob will map to a particular mobskill action packet
    --      if not, the function will use a generic 2-hour action packet
    --          optionally you can override particular action packet params with params.action.X (see that code below)
    -- NOTE these are not arbitrary choices, but multiple options to emulate retail behavior for any particular owner of pets/helpers
    if xi.combat.behavior.isEntityBusy(mob) and not params.ignoreBusy then
        return false
    end

    -- make sure at least one pet is available to summon
    if type(petIds) == 'number' then
        petIds = { petIds }
    elseif petIds == nil then
        -- ensure petIds is always a table so ipairs doesn't fail below
        petIds = mob:getPet() and { mob:getPet():getID() } or {}
    end

    local canSummonPets = false
    for _, petId in ipairs(petIds) do
        local petToSummon = GetMobByID(petId)
        if
            petToSummon and
            not petToSummon:isSpawned()
        then
            canSummonPets = true
        end
    end

    if not canSummonPets then
        return false
    end

    -- don't allow times so short the animations will bug out
    if params.inactiveTime == nil or params.inactiveTime < 1000 then
        params.inactiveTime = 0
    end

    local actionParams = nil
    if params.inactiveTime == 0 and not params.action then
        -- job based action packet
        switch (params.callPetJob) : caseof
        {
            [xi.job.BST] = function(x)
                -- inject "<mob> uses Call Beast"
                actionParams =
                {
                    finishCategory = xi.action.category.MOBABILITY_FINISH,
                    animationID = 718,
                    actionID = xi.mobSkill.CALL_BEAST,
                    messageID = xi.msg.basic.USES,
                    param = 0,
                }
            end,

            [xi.job.DRG] = function(x)
                -- inject "<mob> uses Call Wyvern"
                actionParams =
                {
                    finishCategory = xi.action.category.MOBABILITY_FINISH,
                    animationID = 438,
                    actionID = xi.mobSkill.CALL_WYVERN,
                    messageID = xi.msg.basic.USES,
                    param = 0,
                }
            end,

            [xi.job.PUP] = function(x)
                -- inject "<mob> uses Activate"
                -- The mobskill has no action message, so we use the job ability
                actionParams =
                {
                    finishCategory = xi.action.category.JOBABILITY_FINISH,
                    animationID = 83,
                    actionID = xi.jobAbility.ACTIVATE,
                    messageID = xi.msg.basic.USES_JA,
                    param = 0,
                }
            end,
        }
    end

    params.action = params.action or {}
    if not actionParams then
    -- Generic 2-hour animation with no message or options from params table
        actionParams =
        {
            finishCategory = params.action.finishCategory or 11,
            actionID = params.action.messageID or 307,
            animationID = params.action.animationID or 439,
            messageID = params.action.messageID or 0,
            param = params.action.param or 0,
        }
    end

    -- function to execute when pets are actually called (there may be an inactiveTime)
    local callPetFinish = function(mobArg)
        if mobArg:isDead() then
            return
        end

        -- inject action packet to indicate mob is summoning a pet
        if not params.noAnimation then
            if params.inactiveTime > 0 then
                mobArg:entityAnimationPacket(xi.animationString.CAST_SUMMONER_STOP)
            else
                if actionParams then
                    -- Generic 2-hour animation with no message
                    mobArg:injectActionPacket(mobArg:getID(), actionParams.finishCategory, actionParams.animationID, 0, 0x18, actionParams.messageID, actionParams.actionID, actionParams.param)
                end
            end
        end

        local spawnPos = mobArg:getSpawnPos()
        local pos = mobArg:getPos()
        params.maxSpawns = params.maxSpawns or #petIds
        local spawnedCount = 0
        for _, petId in ipairs(petIds) do
            local petToSummon = GetMobByID(petId)
            if
                spawnedCount < params.maxSpawns and
                petToSummon and
                not petToSummon:isSpawned()
            then
                spawnedCount = spawnedCount + 1
                -- spawn pet around owner
                petToSummon:setSpawn(pos.x + math.random(-2, 2), pos.y, pos.z + math.random(-2, 2), pos.rot)
                petToSummon:spawn()
                -- set home to be the owner's home position
                petToSummon:setSpawn(spawnPos.x, spawnPos.y, spawnPos.z, spawnPos.rot)

                local ownerRoamListenerName = fmt('OWNER_ASSIST_{}', petId)
                if params.superLink then
                    mobArg:addListener('ROAM_TICK', ownerRoamListenerName, function(owner)
                        local petToAssist = GetMobByID(petId)
                        local assistTarg  = petToAssist and petToAssist:getTarget() or nil
                        if assistTarg then
                            owner:updateEnmity(assistTarg)
                        end
                    end)
                end

                -- so they die at the same time
                -- even without this parameter, if the owner is dead and the pet is roaming, it will die
                if params.dieWithOwner then
                    local listenerName = fmt('OWNER_DEATH_{}', petId)
                    mobArg:addListener('DEATH', listenerName, function(owner)
                        local petToKill = GetMobByID(petId)
                        if petToKill and petToKill:isSpawned() then
                            petToKill:setHP(0)
                        end

                        owner:removeListener(listenerName)
                    end)
                end

                -- make pet assist with a slight delay to allow spawn to complete so animations don't get bugged
                local ownerID = mobArg:getID()
                petToSummon:stun(500)
                if petToSummon ~= mobArg:getPet() then
                    petToSummon:addListener('ROAM_TICK', 'ASSIST_OWNER', function(petArg)
                        local owner = GetMobByID(ownerID)
                        local newtarget = owner and owner:getTarget() or nil
                        if newtarget then
                            petArg:updateEnmity(newtarget)
                        elseif owner and owner:isDead() then
                            petArg:setHP(0)
                        elseif not petArg:hasFollowTarget() then
                            petArg:follow(owner, xi.followType.ROAM)
                        end
                    end)

                    -- so we don't wait for the next roam tick (pet assists as soon as :stun is complete)
                    petToSummon:queue(0, function(petArg)
                        petArg:triggerListener('ROAM_TICK', petArg)
                    end)
                end

                -- cleanup any listeners related to this pet when it dies
                -- (:removeListener quietly exits if the listener doesn't exist)
                petToSummon:addListener('DESPAWN', 'PET_LISTENER_CLEANUP', function(petArg)
                    local owner = GetMobByID(ownerID)
                    if owner then
                        owner:removeListener(ownerRoamListenerName)
                    end

                    petArg:removeListener('ASSIST_OWNER')
                    petArg:removeListener('PET_LISTENER_CLEANUP')
                end)
            end
        end
    end

    if params.inactiveTime > 0 then
        -- put owner into inactive state until the timer fires
        mob:stun(params.inactiveTime)

        -- start call pet animation
        if not params.noAnimation then
            mob:entityAnimationPacket(xi.animationString.CAST_SUMMONER_START)
        end
    end

    -- regardless, call the anonymous function from above in params.inactiveTime ms (possibly zero)
    -- note that timers cause xi.combat.behavior.isEntityBusy to return true, and so does mob:stun(X)
    mob:timer(params.inactiveTime, callPetFinish)

    return true
end
