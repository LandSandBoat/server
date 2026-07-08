-----------------------------------
-- Area: Arrapago Reef
--   NM: Bloody Bones
-- !pos 136.234 -6.831 468.779 54
-- TODO: Get more data on the rate at which he uses Malediction. Below 20%, he seems to heavily favor it. 75% is an estimate based on current captures.
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local ID = zones[xi.zone.ARRAPAGO_REEF]
-----------------------------------
---@type TMobEntity
local entity = {}

-- His normal (non-Malediction) TP moves; Malediction usage is handled in onMobMobskillChoose
local normalTpMoves =
{
    xi.mobSkill.HORROR_CLOUD,
    xi.mobSkill.BLACK_CLOUD,
    xi.mobSkill.BLOOD_SABER,
}

entity.spawnPoints =
{
    { x =  136.000, y = -6.000, z =  476.000 }
}

entity.phList =
{
    [ID.mob.BLOODY_BONES - 1] = ID.mob.BLOODY_BONES, -- 136.234 -6.831 468.779
}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.PLAGUE)
    mob:addImmunity(xi.immunity.PETRIFY)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
    mob:setMobMod(xi.mobMod.AOE_HIT_ALL, 1)
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        [ 1] = { xi.magic.spell.BIND,        target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.BIND,     0, 100 },
        [ 2] = { xi.magic.spell.STUN,        target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.STUN,     0, 100 },
        [ 3] = { xi.magic.spell.THUNDER_II,  target, false, xi.action.type.DAMAGE_TARGET,     nil,                0, 100 },
        [ 4] = { xi.magic.spell.ABSORB_VIT,  target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.VIT_DOWN, 0, 100 },
        [ 5] = { xi.magic.spell.DRAIN,       target, false, xi.action.type.DRAIN_HP,          nil,                0, 100 },
        [ 6] = { xi.magic.spell.ABSORB_DEX,  target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.DEX_DOWN, 0, 100 },
        [ 7] = { xi.magic.spell.ABSORB_INT,  target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.INT_DOWN, 0, 100 },
        [ 8] = { xi.magic.spell.BIO_II,      target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.BIO,      4, 100 },
        [ 9] = { xi.magic.spell.ABSORB_AGI,  target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.AGI_DOWN, 0, 100 },
        [10] = { xi.magic.spell.ABSORB_STR,  target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.STR_DOWN, 0, 100 },
        [11] = { xi.magic.spell.ABSORB_TP,   target, false, xi.action.type.DAMAGE_TARGET,     nil,                0, 100 },
        [12] = { xi.magic.spell.POISON_II,   target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.POISON,   0, 100 },
        [13] = { xi.magic.spell.ASPIR,       target, false, xi.action.type.DRAIN_MP,          nil,                0, 100 },
        [14] = { xi.magic.spell.BLIZZARD_II, target, false, xi.action.type.DAMAGE_TARGET,     nil,                0, 100 },
        [15] = { xi.magic.spell.SLEEP_II,    target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.SLEEP_I,  2, 100 },
        [16] = { xi.magic.spell.WATER_III,   target, false, xi.action.type.DAMAGE_TARGET,     nil,                0, 100 },
        [17] = { xi.magic.spell.AERO_II,     target, false, xi.action.type.DAMAGE_TARGET,     nil,                0, 100 },
        [18] = { xi.magic.spell.STONE_III,   target, false, xi.action.type.DAMAGE_TARGET,     nil,                0, 100 },
    }

    return xi.combat.behavior.chooseAction(mob, target, nil, spellList)
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    -- At or above 20% HP his TP moves (Malediction included) shuffle normally
    if mob:getHPP() >= 20 then
        return skillId
    end

    -- Below 20% HP: Malediction 75% of the time, his other TP moves 25% of the time
    if math.randomInt(1, 100) <= 75 then
        return xi.mobSkill.MALEDICTION
    end

    return normalTpMoves[math.randomInt(1, #normalTpMoves)]
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 472)
end

return entity
