-----------------------------------
-- Global version of onMobDeath
-----------------------------------
require("scripts/globals/missions")
require("scripts/globals/quests")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/utils")
require("scripts/globals/zone")
require("scripts/globals/msg")
require("scripts/globals/npc_util")
require("scripts/globals/roe")
-----------------------------------

tpz = tpz or {}
tpz.mob = tpz.mob or {}

-- onMobDeathEx is called from the core
function onMobDeathEx(mob, player, isKiller, isWeaponSkillKill)
    -- Things that happen only to the person who landed killing blow
    if isKiller then
        -- DRK quest - Blade Of Darkness
        if
            (player:getQuestStatus(tpz.quest.log_id.BASTOK, tpz.quest.id.bastok.BLADE_OF_DARKNESS) == QUEST_ACCEPTED or player:getQuestStatus(tpz.quest.log_id.BASTOK, tpz.quest.id.bastok.BLADE_OF_DEATH) == QUEST_ACCEPTED) and
            player:getEquipID(tpz.slot.MAIN) == 16607 and
            player:getCharVar("ChaosbringerKills") < 200 and
            not isWeaponSkillKill
        then
            player:addCharVar("ChaosbringerKills", 1)
        end
    end

    -- Things that happen to any player in the party/alliance
    if player:getCurrentMission(WINDURST) == tpz.mission.id.windurst.A_TESTING_TIME then
        if
            (player:getZoneID() == tpz.zone.BUBURIMU_PENINSULA and player:hasCompletedMission(tpz.mission.log_id.WINDURST, tpz.mission.id.windurst.A_TESTING_TIME)) or
            (player:getZoneID() == tpz.zone.TAHRONGI_CANYON and not player:hasCompletedMission(tpz.mission.log_id.WINDURST, tpz.mission.id.windurst.A_TESTING_TIME))
        then
            player:addCharVar("testingTime_crea_count", 1)
        end
    end

    tpz.magian.checkMagianTrial(player, {['mob'] = mob, ['triggerWs'] = false})
end

-------------------------------------------------
-- placeholder / lottery NMs
-------------------------------------------------

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

-- potential lottery placeholder was killed
tpz.mob.phOnDespawn = function(ph, phList, chance, cooldown, immediate)
    if type(immediate) ~= "boolean" then immediate = false end

    if NM_LOTTERY_CHANCE then
        chance = NM_LOTTERY_CHANCE >= 0 and (chance * NM_LOTTERY_CHANCE) or 100
    end

    if NM_LOTTERYCOOLDOWN then
        cooldown = NM_LOTTERY_COOLDOWN >= 0 and (cooldown * NM_LOTTERY_COOLDOWN) or cooldown
    end

    local phId = ph:getID()
    local nmId = phList[phId]

    if nmId ~= nil then
        local nm = GetMobByID(nmId)
        if nm ~= nil then
            local pop = nm:getLocalVar("pop")

            chance = math.ceil(chance * 10) -- chance / 1000.
            if os.time() > pop and not lotteryPrimed(phList) and math.random(1000) <= chance then

                -- on PH death, replace PH repop with NM repop
                DisallowRespawn(phId, true)
                DisallowRespawn(nmId, false)
                UpdateNMSpawnPoint(nmId)
                nm:setRespawnTime(immediate and 1 or GetMobRespawnTime(phId)) -- if immediate is true, spawn the nm immediately (1ms) else use placeholder's timer

                nm:addListener("DESPAWN", "DESPAWN_" .. nmId, function(m)
                    -- on NM death, replace NM repop with PH repop
                    DisallowRespawn(nmId, true)
                    DisallowRespawn(phId, false)
                    GetMobByID(phId):setRespawnTime(GetMobRespawnTime(phId))
                    m:setLocalVar("pop", os.time() + cooldown)
                    m:removeListener("DESPAWN_" .. nmId)
                end)

                return true
            end
        end
    end

    return false
end

-------------------------------------------------
-- mob additional melee effects
-------------------------------------------------

tpz.mob.additionalEffect =
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
}
tpz.mob.ae = tpz.mob.additionalEffect

local additionalEffects =
{
    [tpz.mob.ae.BLIND] =
    {
        chance = 25,
        ele = tpz.magic.ele.DARK,
        sub = tpz.subEffect.BLIND,
        msg = tpz.msg.basic.ADD_EFFECT_STATUS,
        applyEffect = true,
        eff = tpz.effect.BLINDNESS,
        power = 20,
        duration = 30,
        minDuration = 1,
        maxDuration = 45,
    },
    [tpz.mob.ae.CURSE] =
    {
        chance = 20,
        ele = tpz.magic.ele.DARK,
        sub = tpz.subEffect.CURSE,
        msg = tpz.msg.basic.ADD_EFFECT_STATUS,
        applyEffect = true,
        eff = tpz.effect.CURSE_I,
        power = 50,
        duration = 300,
        minDuration = 1,
        maxDuration = 300,
    },
    [tpz.mob.ae.ENAERO] =
    {
        ele = tpz.magic.ele.WIND,
        sub = tpz.subEffect.WIND_DAMAGE,
        msg = tpz.msg.basic.ADD_EFFECT_DMG,
        negMsg = tpz.msg.basic.ADD_EFFECT_HEAL,
        mod = tpz.mod.INT,
        bonusAbilityParams = {bonusmab = 0, includemab = false},
    },
    [tpz.mob.ae.ENBLIZZARD] =
    {
        ele = tpz.magic.ele.ICE,
        sub = tpz.subEffect.ICE_DAMAGE,
        msg = tpz.msg.basic.ADD_EFFECT_DMG,
        negMsg = tpz.msg.basic.ADD_EFFECT_HEAL,
        mod = tpz.mod.INT,
        bonusAbilityParams = {bonusmab = 0, includemab = false},
    },
    [tpz.mob.ae.ENDARK] =
    {
        ele = tpz.magic.ele.DARK,
        sub = tpz.subEffect.DARKNESS_DAMAGE,
        msg = tpz.msg.basic.ADD_EFFECT_DMG,
        negMsg = tpz.msg.basic.ADD_EFFECT_HEAL,
        mod = tpz.mod.INT,
        bonusAbilityParams = {bonusmab = 0, includemab = false},
    },
    [tpz.mob.ae.ENFIRE] =
    {
        ele = tpz.magic.ele.FIRE,
        sub = tpz.subEffect.FIRE_DAMAGE,
        msg = tpz.msg.basic.ADD_EFFECT_DMG,
        negMsg = tpz.msg.basic.ADD_EFFECT_HEAL,
        mod = tpz.mod.INT,
        bonusAbilityParams = {bonusmab = 0, includemab = false},
    },
    [tpz.mob.ae.ENLIGHT] =
    {
        ele = tpz.magic.ele.LIGHT,
        sub = tpz.subEffect.LIGHT_DAMAGE,
        msg = tpz.msg.basic.ADD_EFFECT_DMG,
        negMsg = tpz.msg.basic.ADD_EFFECT_HEAL,
        mod = tpz.mod.INT,
        bonusAbilityParams = {bonusmab = 0, includemab = false},
    },
    [tpz.mob.ae.ENSTONE] =
    {
        ele = tpz.magic.ele.EARTH,
        sub = tpz.subEffect.EARTH_DAMAGE,
        msg = tpz.msg.basic.ADD_EFFECT_DMG,
        negMsg = tpz.msg.basic.ADD_EFFECT_HEAL,
        mod = tpz.mod.INT,
        bonusAbilityParams = {bonusmab = 0, includemab = false},
    },
    [tpz.mob.ae.ENTHUNDER] =
    {
        ele = tpz.magic.ele.LIGHTNING,
        sub = tpz.subEffect.LIGHTNING_DAMAGE,
        msg = tpz.msg.basic.ADD_EFFECT_DMG,
        negMsg = tpz.msg.basic.ADD_EFFECT_HEAL,
        mod = tpz.mod.INT,
        bonusAbilityParams = {bonusmab = 0, includemab = false},
    },
    [tpz.mob.ae.ENWATER] =
    {
        ele = tpz.magic.ele.WATER,
        sub = tpz.subEffect.WATER_DAMAGE,
        msg = tpz.msg.basic.ADD_EFFECT_DMG,
        negMsg = tpz.msg.basic.ADD_EFFECT_HEAL,
        mod = tpz.mod.INT,
        bonusAbilityParams = {bonusmab = 0, includemab = false},
    },
    [tpz.mob.ae.EVA_DOWN] =
    {
        chance = 25,
        ele = tpz.magic.ele.ICE,
        sub = tpz.subEffect.EVASION_DOWN,
        msg = tpz.msg.basic.ADD_EFFECT_STATUS,
        applyEffect = true,
        eff = tpz.effect.EVASION_DOWN,
        power = 25,
        duration = 30,
        minDuration = 1,
        maxDuration = 60,
    },
    [tpz.mob.ae.HP_DRAIN] =
    {
        chance = 10,
        ele = tpz.magic.ele.DARK,
        sub = tpz.subEffect.HP_DRAIN,
        msg = tpz.msg.basic.ADD_EFFECT_HP_DRAIN,
        mod = tpz.mod.INT,
        bonusAbilityParams = {bonusmab = 0, includemab = false},
        code = function(mob, target, power) mob:addHP(power) end,
    },
    [tpz.mob.ae.MP_DRAIN] =
    {
        chance = 10,
        ele = tpz.magic.ele.DARK,
        sub = tpz.subEffect.MP_DRAIN,
        msg = tpz.msg.basic.ADD_EFFECT_MP_DRAIN,
        mod = tpz.mod.INT,
        bonusAbilityParams = {bonusmab = 0, includemab = false},
        code = function(mob, target, power) local mp = math.min(power, target:getMP()) target:delMP(mp) mob:addMP(mp) end,
    },
    [tpz.mob.ae.PARALYZE] =
    {
        chance = 25,
        ele = tpz.magic.ele.ICE,
        sub = tpz.subEffect.PARALYSIS,
        msg = tpz.msg.basic.ADD_EFFECT_STATUS,
        applyEffect = true,
        eff = tpz.effect.PARALYSIS,
        power = 20,
        duration = 30,
        minDuration = 1,
        maxDuration = 60,
    },
    [tpz.mob.ae.PETRIFY] =
    {
        chance = 20,
        ele = tpz.magic.ele.EARTH,
        sub = tpz.subEffect.PETRIFY,
        msg = tpz.msg.basic.ADD_EFFECT_STATUS,
        applyEffect = true,
        eff = tpz.effect.PETRIFICATION,
        power = 1,
        duration = 30,
        minDuration = 1,
        maxDuration = 45,
    },
    [tpz.mob.ae.PLAGUE] =
    {
        chance = 25,
        ele = tpz.magic.ele.WATER,
        sub = tpz.subEffect.PLAGUE,
        msg = tpz.msg.basic.ADD_EFFECT_STATUS,
        applyEffect = true,
        eff = tpz.effect.PLAGUE,
        power = 1,
        duration = 60,
        minDuration = 1,
        maxDuration = 60,
    },
    [tpz.mob.ae.POISON] =
    {
        chance = 25,
        ele = tpz.magic.ele.WATER,
        sub = tpz.subEffect.POISON,
        msg = tpz.msg.basic.ADD_EFFECT_STATUS,
        applyEffect = true,
        eff = tpz.effect.POISON,
        power = 1,
        duration = 30,
        minDuration = 1,
        maxDuration = 30,
        tick = 3,
    },
    [tpz.mob.ae.SILENCE] =
    {
        chance = 25,
        ele = tpz.magic.ele.WIND,
        sub = tpz.subEffect.SILENCE,
        msg = tpz.msg.basic.ADD_EFFECT_STATUS,
        applyEffect = true,
        eff = tpz.effect.SILENCE,
        power = 1,
        duration = 30,
        minDuration = 1,
        maxDuration = 30,
    },
    [tpz.mob.ae.SLOW] =
    {
        chance = 25,
        ele = tpz.magic.ele.EARTH,
        sub = tpz.subEffect.DEFENSE_DOWN,
        msg = tpz.msg.basic.ADD_EFFECT_STATUS,
        applyEffect = true,
        eff = tpz.effect.SLOW,
        power = 1000,
        duration = 30,
        minDuration = 1,
        maxDuration = 45,
    },
    [tpz.mob.ae.STUN] =
    {
        chance = 20,
        ele = tpz.magic.ele.LIGHTNING,
        sub = tpz.subEffect.STUN,
        msg = tpz.msg.basic.ADD_EFFECT_STATUS,
        applyEffect = true,
        eff = tpz.effect.STUN,
        duration = 5,
    },
    [tpz.mob.ae.TERROR] =
    {
        chance = 20,
        sub = tpz.subEffect.PARALYSIS,
        msg = tpz.msg.basic.ADD_EFFECT_STATUS,
        applyEffect = true,
        eff = tpz.effect.TERROR,
        duration = 5,
        code = function(mob, target, power) mob:resetEnmity(target) end,
    },
    [tpz.mob.ae.TP_DRAIN] =
    {
        chance = 25,
        ele = tpz.magic.ele.DARK,
        sub = tpz.subEffect.TP_DRAIN,
        msg = tpz.msg.basic.ADD_EFFECT_TP_DRAIN,
        mod = tpz.mod.INT,
        bonusAbilityParams = {bonusmab = 0, includemab = false},
        code = function(mob, target, power) local tp = math.min(power, target:getTP()) target:delTP(tp) mob:addTP(tp) end,
    },
}

--[[
    mob, target, and damage are passed from core into mob script's onAdditionalEffect
    effect should be of type tpz.mob.additionalEffect (see above)
    params is a table that can contain any of:
        chance: percent chance that effect procs on hit (default 20)
        power: power of effect
        duration: duration of effect, in seconds
        code: additional code that will run when effect procs, of form function(mob, target, power)
    params will override effect's default settings
--]]
tpz.mob.onAddEffect = function(mob, target, damage, effect, params)
    if type(params) ~= "table" then params = {} end

    local ae = additionalEffects[effect]

    if ae then
        local chance = params.chance or ae.chance or 100
        local dLevel = target:getMainLvl() - mob:getMainLvl()

        if dLevel > 0 then
            chance = chance - 5 * dLevel
            chance = utils.clamp(chance, 5, 95)
        end

        -- target:PrintToPlayer(string.format("Chance: %i", chance)) -- DEBUG

        if math.random(100) <= chance then

            -- STATUS EFFECT
            if ae.applyEffect then
                local resist = 1
                if ae.ele then
                    resist = applyResistanceAddEffect(mob, target, ae.ele, ae.eff)
                end

                if resist > 0.5 and not target:hasStatusEffect(ae.eff) then
                    local power = params.power or ae.power or 0
                    local tick = ae.tick or 0
                    local duration = params.duration or ae.duration

                    if dLevel < 0 then
                        duration = duration - dLevel
                    end

                    if ae.minDuration and duration < ae.minDuration then
                        duration = ae.minDuration
                    elseif ae.maxDuration and duration > ae.maxDuration then
                        duration = ae.maxDuration
                    end

                    duration = duration * resist

                    target:addStatusEffect(ae.eff, power, tick, duration)

                    if params.code then
                        params.code(mob, target, power)
                    elseif ae.code then
                        ae.code(mob, target, power)
                    end

                    return ae.sub, ae.msg, ae.eff
                end

            -- IMMEDIATE EFFECT
            else
                local power = 0

                if params.power then
                    power = params.power
                elseif ae.mod then
                    local dMod = mob:getStat(ae.mod) - target:getStat(ae.mod)

                    if dMod > 20 then
                        dMod = 20 + (dMod - 20) / 2
                    end

                    power = dMod + target:getMainLvl() - mob:getMainLvl() + damage / 2
                end

                -- target:PrintToPlayer(string.format("Initial Power: %f", power)) -- DEBUG

                power = addBonusesAbility(mob, ae.ele, target, power, ae.bonusAbilityParams)
                power = power * applyResistanceAddEffect(mob, target, ae.ele, 0)
                power = adjustForTarget(target, power, ae.ele)
                power = finalMagicNonSpellAdjustments(mob, target, ae.ele, power)

                -- target:PrintToPlayer(string.format("Adjusted Power: %f", power)) -- DEBUG

                local message = ae.msg
                if power < 0 then
                    if ae.negMsg then
                        message = ae.negMsg
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
            end
        end
    else
        printf("invalid additional effect for mobId %i", mob:getID())
    end

    return 0, 0, 0
end
