-----------------------------------
-- Area: Attohwa Chasm
--  Mob: Citipati
-----------------------------------
local ID = zones[xi.zone.ATTOHWA_CHASM]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.CITIPATI - 1] = ID.mob.CITIPATI, -- Confirmed on retail
}

entity.spawnPoints =
{
    { x = -364.014, y = -4.634,  z = -2.627 },
    { x = -328.973, y = -12.876, z = 67.481 },
    { x = -398.931, y = -4.536,  z = 79.640 },
    { x = -381.284, y = -9.233,  z = 40.054 },
}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.BIND_RES_RANK, 10)
    mob:setMod(xi.mod.DARK_RES_RANK, 10)
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
end

entity.onMobRoam = function(mob)
    -- Since DisallowRespawn() doesn't care about SPAWNTYPE_NIGHT we have to get creative
    local totd = VanadielTOTD()
    if totd ~= xi.time.NIGHT and totd ~= xi.time.MIDNIGHT then
        mob:setLocalVar('doNotInvokeCooldown', 1)
        DespawnMob(mob:getID())
    end
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        [ 1] = { xi.magic.spell.ICE_SPIKES,  mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.ICE_SPIKES, 0, 100 },
        [ 2] = { xi.magic.spell.SLEEP_II,    target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.SLEEP_I,    2, 100 },
        [ 3] = { xi.magic.spell.SLEEPGA_II,  target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.SLEEP_I,    2, 100 },
        [ 4] = { xi.magic.spell.SLEEP,       target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.SLEEP_I,    1, 100 },
        [ 5] = { xi.magic.spell.SLEEPGA,     target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.SLEEP_I,    1, 100 },
        [ 6] = { xi.magic.spell.BLIND,       target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.BLINDNESS,  0, 100 },
        [ 7] = { xi.magic.spell.FROST,       target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.FROST,      0, 100 },
        [ 8] = { xi.magic.spell.CHOKE,       target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.CHOKE,      0, 100 },
        [ 9] = { xi.magic.spell.BIO_II,      target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.BIO,        4, 100 },
        [10] = { xi.magic.spell.POISONGA_II, target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.POISON,     0, 100 },
        [11] = { xi.magic.spell.ASPIR,       target, false, xi.action.type.DRAIN_MP,             nil,                  0, 100 },
        [12] = { xi.magic.spell.STONE_IV,    target, false, xi.action.type.DAMAGE_TARGET,        nil,                  0, 100 },
        [13] = { xi.magic.spell.THUNDER_III, target, false, xi.action.type.DAMAGE_TARGET,        nil,                  0, 100 },
        [14] = { xi.magic.spell.BURST,       target, false, xi.action.type.DAMAGE_TARGET,        nil,                  0, 100 },
        [15] = { xi.magic.spell.FLOOD,       target, false, xi.action.type.DAMAGE_TARGET,        nil,                  0, 100 },
        [16] = { xi.magic.spell.WATER_IV,    target, false, xi.action.type.DAMAGE_TARGET,        nil,                  0, 100 },
        [17] = { xi.magic.spell.STONEGA_III, target, false, xi.action.type.DAMAGE_TARGET,        nil,                  0, 100 },
        [18] = { xi.magic.spell.BLIZZAGA_II, target, false, xi.action.type.DAMAGE_TARGET,        nil,                  0, 100 },
        [19] = { xi.magic.spell.AEROGA_III,  target, false, xi.action.type.DAMAGE_TARGET,        nil,                  0, 100 },
        [20] = { xi.magic.spell.DRAIN,       target, false, xi.action.type.DRAIN_HP,             nil,                  0, 100 },
    }

    return xi.combat.behavior.chooseAction(mob, target, nil, spellList)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 278)
end

return entity
