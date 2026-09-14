-----------------------------------
-- Area: Castle Zvahl Baileys (161)
-- NM: Marquis Andrealphus
-- Quest: Better The Demon You Know
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local zvahlID = zones[xi.zone.CASTLE_ZVAHL_BAILEYS]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addListener('EFFECT_GAIN', 'MARQUIS_BLOOD_WEAPON_GAIN', function(mobArg, effect)
        if effect:getEffectType() == xi.effect.BLOOD_WEAPON then
            mobArg:setMod(xi.mod.HASTE_ABILITY, 2500)
        end
    end)

    mob:addListener('EFFECT_LOSE', 'MARQUIS_BLOOD_WEAPON_LOSE', function(mobArg, effect)
        if effect:getEffectType() == xi.effect.BLOOD_WEAPON then
            mobArg:setMod(xi.mod.HASTE_ABILITY, 0)
        end
    end)
end

entity.onMobSpawn = function(mob)
    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            { id = xi.mobSkill.BLOOD_WEAPON_1, cooldown = 180, hpp = 70 },
        },
    })

    mob:setMod(xi.mod.HASTE_ABILITY, 0)

    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180) -- 3 minutes
    mob:setMobMod(xi.mobMod.ALWAYS_AGGRO, 1) -- Will agro any player reguardless of level
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.BLIND)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.SLOW)
    mob:addImmunity(xi.immunity.STUN)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.POISON)
    mob:addImmunity(xi.immunity.ELEGY)
    mob:addImmunity(xi.immunity.PLAGUE)
    mob:addImmunity(xi.immunity.TERROR)
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        [ 1] = { xi.magic.spell.FIRE,       target, false, xi.action.type.DAMAGE_TARGET,     nil,                0, 100 },
        [ 2] = { xi.magic.spell.BLIZZARD,   target, false, xi.action.type.DAMAGE_TARGET,     nil,                0, 100 },
        [ 3] = { xi.magic.spell.AERO,       target, false, xi.action.type.DAMAGE_TARGET,     nil,                0, 100 },
        [ 4] = { xi.magic.spell.STONE_II,   target, false, xi.action.type.DAMAGE_TARGET,     nil,                0, 100 },
        [ 5] = { xi.magic.spell.THUNDER,    target, false, xi.action.type.DAMAGE_TARGET,     nil,                0, 100 },
        [ 6] = { xi.magic.spell.WATER_II,   target, false, xi.action.type.DAMAGE_TARGET,     nil,                0, 100 },
        [ 7] = { xi.magic.spell.POISON,     target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.POISON,   1, 100 },
        [ 8] = { xi.magic.spell.BIO_II,     target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.BIO,      4, 100 },
        [ 9] = { xi.magic.spell.DRAIN,      target, false, xi.action.type.DRAIN_HP,          nil,                0, 100 },
        [10] = { xi.magic.spell.ASPIR,      target, false, xi.action.type.DRAIN_MP,          nil,                0, 100 },
        [11] = { xi.magic.spell.STUN,       target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.STUN,     1, 100 },
        [12] = { xi.magic.spell.ABSORB_STR, target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.STR_DOWN, 0, 100 },
        [13] = { xi.magic.spell.ABSORB_DEX, target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.DEX_DOWN, 0, 100 },
        [14] = { xi.magic.spell.ABSORB_VIT, target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.VIT_DOWN, 0, 100 },
        [15] = { xi.magic.spell.ABSORB_AGI, target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.AGI_DOWN, 0, 100 },
        [16] = { xi.magic.spell.ABSORB_INT, target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.INT_DOWN, 0, 100 },
        [17] = { xi.magic.spell.ABSORB_MND, target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.MND_DOWN, 0, 100 },
        [18] = { xi.magic.spell.ABSORB_CHR, target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.CHR_DOWN, 0, 100 },
        [19] = { xi.magic.spell.ABSORB_TP,  target, false, xi.action.type.DAMAGE_TARGET,     nil,                0, 100 },
    }

    return xi.combat.behavior.chooseAction(mob, target, nil, spellList)
end

entity.onMobFight = function(mob, target)
    local hpp = mob:getHPP()
    local escapePlayer = mob:getLocalVar('castEscape')

    -- Attempts Substitute on the current target at 80% and 40% HP.
    -- Retail captures show him using Substitute with a Trust tanking.
    if
        hpp <= 40 and
        escapePlayer < 2
    then
        mob:setLocalVar('castEscape', 2)
        mob:useMobAbility(xi.mobSkill.SUBSTITUTE)
        mob:messageText(mob, zvahlID.text.BEGONE_FROM_THESE_HALLS)
    elseif
        hpp <= 80 and
        escapePlayer == 0
    then
        mob:setLocalVar('castEscape', 1)
        mob:useMobAbility(xi.mobSkill.SUBSTITUTE)
        mob:messageText(mob, zvahlID.text.BEGONE_FROM_THESE_HALLS)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    -- Despawns the "Demon Banneret" and "Demon Secretary" adds
    local mobId = mob:getID()

    for i = mobId + 1, mobId + 4 do
        if GetMobByID(i):isSpawned() then
            DespawnMob(i)
        end
    end
end

entity.onMobDespawn = function(mob)
    -- Despawns the "Demon Banneret" and "Demon Secretary" adds
    local mobId = mob:getID()

    for i = mobId + 1, mobId + 4 do
        if GetMobByID(i):isSpawned() then
            DespawnMob(i)
        end
    end
end

return entity
