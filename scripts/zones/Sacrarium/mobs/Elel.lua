-----------------------------------
-- Area: Sacrarium
--   NM: Elel
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:setMobMod(xi.mobMod.ALWAYS_AGGRO, 1)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.BIND_RES_RANK, 10)
    mob:setMod(xi.mod.DARK_RES_RANK, 10)
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
end

entity.onMobRoam = function(mob)
    local hour    = VanadielHour()
    local weather = mob:getWeather()
    if
        (hour >= 4 and hour < 20) or                                     -- Not night.
        (weather ~= xi.weather.GLOOM and weather ~= xi.weather.DARKNESS) -- Not dark weather.
    then
        DespawnMob(mob:getID())
    end
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        [ 1] = { xi.magic.spell.ICE_SPIKES,  mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.ICE_SPIKES, 0, 100 },
        [ 2] = { xi.magic.spell.SLEEP_II,    target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.SLEEP_I,    2, 100 },
        [ 3] = { xi.magic.spell.SLEEPGA,     target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.SLEEP_I,    1, 100 },
        [ 4] = { xi.magic.spell.BLIND,       target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.BLINDNESS,  1, 100 },
        [ 5] = { xi.magic.spell.BIND,        target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.BIND,       1, 100 },
        [ 6] = { xi.magic.spell.POISON_II,   target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.POISON,     2, 100 },
        [ 7] = { xi.magic.spell.BIO_II,      target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.BIO,        4, 100 },
        [ 8] = { xi.magic.spell.DROWN,       target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.DROWN,      1, 100 },
        [ 9] = { xi.magic.spell.CHOKE,       target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.CHOKE,      1, 100 },
        [10] = { xi.magic.spell.RASP,        target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.RASP,       1, 100 },
        [11] = { xi.magic.spell.ASPIR,       target, false, xi.action.type.DRAIN_MP,             nil,                  0, 100 },
        [12] = { xi.magic.spell.STONE_III,   target, false, xi.action.type.DAMAGE_TARGET,        nil,                  0, 100 },
        [13] = { xi.magic.spell.WATER_III,   target, false, xi.action.type.DAMAGE_TARGET,        nil,                  0, 100 },
        [14] = { xi.magic.spell.BLIZZAGA_II, target, false, xi.action.type.DAMAGE_TARGET,        nil,                  0, 100 },
        [15] = { xi.magic.spell.QUAKE,       target, false, xi.action.type.DAMAGE_TARGET,        nil,                  0, 100 },
    }

    return xi.combat.behavior.chooseAction(mob, target, nil, spellList)
end

entity.onMobDeath = function(mob, player, optParams)
    mob:setLocalVar('cooldown', GetSystemTime() + 7200)
end

-- TODO: implement/verify this "alternates nights with dark weather" claim on ffxiclopedia.
-- Currently assuming it works like Xolotl where it will just spawn the next time it can (dark weather, night time)
entity.onMobDespawn = function(mob)
    --xi.mob.updateNMSpawnPoint(mob) -- TODO: add more spawn points
    DisallowRespawn(mob:getID(), true) -- prevents accidental 'pop' during no dark weather and immediate despawn
end

return entity
