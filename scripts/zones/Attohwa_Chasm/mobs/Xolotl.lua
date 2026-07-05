-----------------------------------
-- Area: Attohwa Chasm
--  Mob: Xolotl
-- Note: The 2 pets do NOT despawn if engaged when Xolotl dies, nor do they
--       despawn if Xolotl disengages. Xolotl summons one pet at a time, on a
--       separate timer for each: shortly after spawning (while roaming) and 60
--       seconds after the pet dies.
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

local ID = zones[xi.zone.ATTOHWA_CHASM]

local pets =
{
    ID.mob.XOLOTL + 1, -- Xolotl's Hound Warrior
    ID.mob.XOLOTL + 2, -- Xolotl's Sacrifice
}

local callPetParams =
{
    superLink = true,
    maxSpawns = 1,
    inactiveTime = 3000,
}

local function spawnPets(mob)
    if mob:getLocalVar('hound_spawn_time') < GetSystemTime() then
        xi.mob.callPets(mob, pets[1], callPetParams)
    end

    if mob:getLocalVar('sacrifice_spawn_time') < GetSystemTime() then
        xi.mob.callPets(mob, pets[2], callPetParams)
    end
end

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar('killed', 0)
    mob:setMod(xi.mod.BIND_RES_RANK, 10)
    mob:setMod(xi.mod.DARK_RES_RANK, 10)
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
    mob:setMod(xi.mod.POWER_MULTIPLIER_SPELL, 12)

    -- Start the pet-call timers at spawn so the pets are summoned while roaming,
    -- 60 seconds after Xolotl spawns, before he is ever engaged.
    mob:setLocalVar('hound_spawn_time', GetSystemTime() + 60)
    mob:setLocalVar('sacrifice_spawn_time', GetSystemTime() + 60)
end

entity.onMobRoam = function(mob)
    spawnPets(mob)
end

entity.onMobFight = function(mob)
    spawnPets(mob)
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        [ 1] = { xi.magic.spell.ICE_SPIKES,   mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.ICE_SPIKES, 0, 100 },
        [ 2] = { xi.magic.spell.SLEEPGA_II,   target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.SLEEP_I,    2, 100 },
        [ 3] = { xi.magic.spell.SLEEP,        target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.SLEEP_I,    1, 100 },
        [ 4] = { xi.magic.spell.BLIND,        target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.BLINDNESS,  0, 100 },
        [ 5] = { xi.magic.spell.BIND,         target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.BIND,       0, 100 },
        [ 6] = { xi.magic.spell.STUN,         target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.STUN,       0, 100 },
        [ 7] = { xi.magic.spell.FROST,        target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.FROST,      0, 100 },
        [ 8] = { xi.magic.spell.CHOKE,        target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.CHOKE,      0, 100 },
        [ 9] = { xi.magic.spell.RASP,         target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.RASP,       0, 100 },
        [10] = { xi.magic.spell.DROWN,        target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.DROWN,      0, 100 },
        [11] = { xi.magic.spell.BIO_II,       target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.BIO,        4, 100 },
        [12] = { xi.magic.spell.POISONGA_II,  target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.POISON,     0, 100 },
        [13] = { xi.magic.spell.ASPIR,        target, false, xi.action.type.DRAIN_MP,             nil,                  0, 100 },
        [14] = { xi.magic.spell.DRAIN,        target, false, xi.action.type.DRAIN_HP,             nil,                  0, 100 },
        [15] = { xi.magic.spell.BLIZZAGA_III, target, false, xi.action.type.DAMAGE_TARGET,        nil,                  0, 100 },
        [16] = { xi.magic.spell.BLIZZARD_IV,  target, false, xi.action.type.DAMAGE_TARGET,        nil,                  0, 100 },
        [17] = { xi.magic.spell.AERO_IV,      target, false, xi.action.type.DAMAGE_TARGET,        nil,                  0, 100 },
        [18] = { xi.magic.spell.WATER_IV,     target, false, xi.action.type.DAMAGE_TARGET,        nil,                  0, 100 },
        [19] = { xi.magic.spell.FLOOD,        target, false, xi.action.type.DAMAGE_TARGET,        nil,                  0, 100 },
        [20] = { xi.magic.spell.THUNDER_IV,   target, false, xi.action.type.DAMAGE_TARGET,        nil,                  0, 100 },
        [21] = { xi.magic.spell.BURST,        target, false, xi.action.type.DAMAGE_TARGET,        nil,                  0, 100 },
        [22] = { xi.magic.spell.THUNDAGA_III, target, false, xi.action.type.DAMAGE_TARGET,        nil,                  0, 100 },
        [23] = { xi.magic.spell.AEROGA_III,   target, false, xi.action.type.DAMAGE_TARGET,        nil,                  0, 100 },
    }

    return xi.combat.behavior.chooseAction(mob, target, nil, spellList)
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        mob:setLocalVar('killed', 1)
    end

    if player then
        player:addTitle(xi.title.XOLOTL_XTRAPOLATOR)
    end
end

entity.onMobDespawn = function(mob)
    -- Only set long respawn timer if killed, not if naturally despawned at dawn
    if mob:getLocalVar('killed') == 1 then
        mob:setRespawnTime(math.randomInt(75600, 86400))
    else
        mob:setRespawnTime(1)
    end
end

return entity
