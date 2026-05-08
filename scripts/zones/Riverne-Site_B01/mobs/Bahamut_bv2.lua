-----------------------------------
-- Area: Riverne - Site B01 (BCNM)
-- NM: Bahamut V2
-- !pos -612.800 1.750 693.190 29
-- Uses a flare ability at 90%, 80%, 70%, 60%, 50%, 40%, 30%, 20%, and 10% HP and repeatedly below 10% until death.
-- At 10% HP, Bahamut will stop using magic and only use auto-attacks and Teraflare.
-- Summons a Wyrm at 80%, 60%, 40%, and 20% HP. The Wyrms are Ouryu, Tiamat, Jormungand, and Vrtra, but they spawn in random order.
-- Combat loop will always prioritze using the next Flare in the sequence over summoning a Wyrm due to early returns. This is retail accurate.
-----------------------------------
local ID = zones[xi.zone.RIVERNE_SITE_B01]
-----------------------------------
---@type TMobEntity
local entity = {}

local flareTable =
{
    [ 1] = { 90, xi.mobSkill.MEGAFLARE },
    [ 2] = { 80, xi.mobSkill.MEGAFLARE },
    [ 3] = { 70, xi.mobSkill.MEGAFLARE },
    [ 4] = { 60, xi.mobSkill.GIGAFLARE },
    [ 5] = { 50, xi.mobSkill.GIGAFLARE },
    [ 6] = { 40, xi.mobSkill.GIGAFLARE },
    [ 7] = { 30, xi.mobSkill.GIGAFLARE },
    [ 8] = { 20, xi.mobSkill.GIGAFLARE },
    [ 9] = { 10, xi.mobSkill.TERAFLARE },
    [10] = {  0, xi.mobSkill.TERAFLARE },
}

local wyrms =
{
    ID.mob.BAHAMUT_V2 + 1, ID.mob.BAHAMUT_V2 + 2, ID.mob.BAHAMUT_V2 + 3, ID.mob.BAHAMUT_V2 + 4 -- Ouryu, Tiamat, Jormungand, Vrtra
}

local wyrmTable =
{
    [1] = { 80, 1 },
    [2] = { 60, 2 },
    [3] = { 40, 3 },
    [4] = { 20, 4 },
}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.PARALYZE)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.PETRIFY)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
    mob:setMobMod(xi.mobMod.SIGHT_RANGE, 20)
    mob:setMobMod(xi.mobMod.SOUND_RANGE, 20)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 45)
    mob:setMobMod(xi.mobMod.WEAPON_BONUS, 156)
    mob:setMod(xi.mod.UFASTCAST, 15)
    mob:setMod(xi.mod.ATT, 376)
    mob:setMod(xi.mod.INT, 21)
    mob:setMod(xi.mod.MATT, 12)
    mob:setMod(xi.mod.ATT, 425)
    mob:addMod(xi.mod.REGAIN, 150)
    mob:addMod(xi.mod.REGEN, 50)
    mob:setMod(xi.mod.MDEF, 62)
    mob:addStatusEffect(xi.effect.PHALANX, { power = 35, duration = 180, origin = mob })
    mob:addStatusEffect(xi.effect.STONESKIN, { power = 350, duration = 300, origin = mob })
    mob:addStatusEffect(xi.effect.PROTECT, { power = 175, duration = 1800, origin = mob })
    mob:addStatusEffect(xi.effect.SHELL, { power = 24, duration = 1800, origin = mob })
    mob:setBehavior(xi.behavior.NO_TURN)
    mob:setMobAbilityEnabled(true)
    mob:setMagicCastingEnabled(true)
    mob:setAutoAttackEnabled(true)
    local randomOrder = utils.shuffle(wyrms)
    mob:setLocalVar('wyrm1', randomOrder[1])
    mob:setLocalVar('wyrm2', randomOrder[2])
    mob:setLocalVar('wyrm3', randomOrder[3])
    mob:setLocalVar('wyrm4', randomOrder[4])
    mob:setLocalVar('flarePhase', 1)
    mob:setLocalVar('wyrmsCalled', 0)
    mob:setLocalVar('isBusy', 0)
end

entity.onMobFight = function(mob, target)
    if xi.combat.behavior.isEntityBusy(mob) then
        return
    end

    local hpPercent       = mob:getHPP()
    local flarePhase      = mob:getLocalVar('flarePhase')
    local messagePlayed   = mob:getLocalVar('messagePlayed')

    local phaseData = flareTable[flarePhase]

    if not phaseData then
        return
    end

    local flareThreshold = phaseData[1]
    local flare     = phaseData[2]

    -- Check to see if we need to use a flare. If so, start the sequence and route the messages based off phase.
    if
        hpPercent < flareThreshold and
        messagePlayed == 0
    then
        mob:setMobAbilityEnabled(false)
        mob:setMagicCastingEnabled(false)
        mob:setAutoAttackEnabled(false)
        if flarePhase < 4 then
            mob:messageText(mob, ID.text.BAHAMUT_TAUNT)
            mob:setLocalVar('messagePlayed', 1)
            mob:timer(2000, function(mobArg)
                mobArg:messageText(mobArg, ID.text.BAHAMUT_TAUNT + 1)
                mobArg:setLocalVar('messagePlayed', 2)
            end)

        elseif flarePhase < 9 then
            mob:messageText(mob, ID.text.BAHAMUT_TAUNT + (math.random(0, 1) == 0 and 2 or 14))
            mob:setLocalVar('messagePlayed', 2)

        elseif flarePhase == 9 then
            mob:messageText(mob, ID.text.BAHAMUT_TAUNT + 3)
            mob:setLocalVar('messagePlayed', 1)
            mob:timer(2000, function(mobArg)
                mobArg:messageText(mobArg, ID.text.BAHAMUT_TAUNT + 4)
            end)

            mob:timer(4000, function(mobArg)
                mobArg:messageText(mobArg, ID.text.BAHAMUT_TAUNT + 5)
                mobArg:setLocalVar('messagePlayed', 2)
            end)
        end
    return
    end

    -- Use Megaflare / Gigaflare / Teraflare - Restore Magic/Attack/Abilities then advance the phase. If it's phase 10, turn off magic and switch to Teraflare only.
    if
        messagePlayed == 2 and
        mob:checkDistance(target) <= 15
    then
        mob:useMobAbility(flare)
        mob:setLocalVar('messagePlayed', 0)
        mob:setLocalVar('flarePhase', flarePhase + 1)

        if flarePhase < 10 then
            mob:setMobAbilityEnabled(true)
            mob:setAutoAttackEnabled(true)
            mob:setMagicCastingEnabled(true)
        else
            mob:setAutoAttackEnabled(true)
            mob:setMobAbilityEnabled(true)
            mob:setMod(xi.mod.REGAIN, 50)
        end

        return
    end

    -- If we make it here, check to see if it's time to summon a Wyrm. If so, start that sequence and gate the loop with isBusy.
    local wyrmsCalled = mob:getLocalVar('wyrmsCalled')
    local wyrmPhase = wyrmTable[wyrmsCalled + 1]

    if
        wyrmPhase and
        hpPercent <= wyrmPhase[1] and
        messagePlayed == 0
    then
        mob:setLocalVar('isBusy', 1)
        mob:messageText(mob, ID.text.BAHAMUT_TAUNT + 6)
        mob:timer(2000, function(mobArg)
            mobArg:messageText(mobArg, ID.text.BAHAMUT_TAUNT + 7)
        end)

        mob:timer(4000, function(mobArg)
            mobArg:messageText(mobArg, ID.text.BAHAMUT_TAUNT + 8)
            mobArg:useMobAbility(xi.mobSkill.CALL_OF_THE_WYRMKING)
            mobArg:setLocalVar('isBusy', 0)
        end)

        mob:timer(5500, function(mobArg)
            GetMobByID(mobArg:getLocalVar('wyrm' .. wyrmPhase[2])):spawn()
            mobArg:setLocalVar('wyrmsCalled', wyrmsCalled + 1)
        end)
    end
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    local skillList =
    {
        xi.mobSkill.TRAMPLE_BAHAMUT,
        xi.mobSkill.TEMPEST_WING,
        xi.mobSkill.TOUCHDOWN_BAHAMUT,
        xi.mobSkill.SWEEPING_FLAIL,
        xi.mobSkill.PRODIGIOUS_SPIKE,
        xi.mobSkill.IMPULSION,
        xi.mobSkill.ABSOLUTE_TERROR_BAHAMUT,
        xi.mobSkill.HORRIBLE_ROAR_BAHAMUT
    }

    if mob:getLocalVar('flarePhase') == 10 then
        return xi.mobSkill.TERAFLARE
    else
        return skillList[math.random(1, #skillList)]
    end
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        [ 1] = { xi.magic.spell.FIRE_V,    target, false, xi.action.type.DAMAGE_TARGET,        nil,                 0, 100 },
        [ 2] = { xi.magic.spell.FIRAGA_IV, target, false, xi.action.type.DAMAGE_TARGET,        nil,                 0, 100 },
        [ 3] = { xi.magic.spell.FLARE_II,  target, false, xi.action.type.DAMAGE_TARGET,        nil,                 0, 100 },
        [ 4] = { xi.magic.spell.CURE_V,    mob,    false, xi.action.type.HEALING_TARGET,       50,                  0, 100 },
        [ 5] = { xi.magic.spell.SILENCEGA, target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.SILENCE,   0, 100 },
        [ 6] = { xi.magic.spell.GRAVIGA,   target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.WEIGHT,    0, 100 },
        [ 7] = { xi.magic.spell.PROTECT_V, mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.PROTECT,   0, 100 },
        [ 8] = { xi.magic.spell.SHELL_V,   mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.SHELL,     0, 100 },
        [ 9] = { xi.magic.spell.STONESKIN, mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.STONESKIN, 0, 100 },
        [10] = { xi.magic.spell.PHALANX,   mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.PHALANX,   0, 100 },
    }

    if target:hasStatusEffectByFlag(xi.effectFlag.DISPELABLE) then
        table.insert(spellList, #spellList + 1, { xi.magic.spell.DISPELGA, target, false, xi.action.type.NONE, nil, 0, 100 })
    end

    return xi.combat.behavior.chooseAction(mob, target, nil, spellList)
end

entity.onMobDeath = function(mob, player, optParams)
    if player then
        player:addTitle(xi.title.WYRM_ASTONISHER)
    end

    if optParams.isKiller or optParams.noKiller then
        mob:messageText(mob, ID.text.BAHAMUT_TAUNT + 9)

        mob:timer(2000, function(mobArg)
            mobArg:messageText(mobArg, ID.text.BAHAMUT_TAUNT + 10)
        end)

        mob:timer(4000, function(mobArg)
            mobArg:messageText(mobArg, ID.text.BAHAMUT_TAUNT + 11)
        end)

        for i = 1, 16 do
            -- Defeat all additional enemies in the battlefield on death.
            local bahamutSummons = GetMobByID(ID.mob.BAHAMUT_V2 + i)
            if bahamutSummons and bahamutSummons:isAlive() then
                bahamutSummons:setHP(0)
            end
        end
    end
end

return entity
