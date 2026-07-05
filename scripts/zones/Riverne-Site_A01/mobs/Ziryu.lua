-----------------------------------
-- Area: Riverne - Site A01
-- Mob: Ziryu
-- Notes: in Ouryu Cometh
-----------------------------------
---@type TMobEntity
local entity = {}

local spawnPoints =
{
    { x = -7.673, y = 76.109, z = -753.720 },
    { x = -5.680, y = 76.098, z = -753.375 },
    { x = -5.063, y = 76.632, z = -769.115 },
    { x = -4.365, y = 76.112, z = -750.562 },
    { x = -2.091, y = 76.000, z = -718.037 },
    { x = -0.636, y = 76.000, z = -763.672 },
    { x = 0.744,  y = 76.462, z = -712.730 },
    { x = 0.834,  y = 76.032, z = -721.327 },
    { x = 3.663,  y = 76.234, z = -710.823 },
    { x = 5.228,  y = 76.399, z = -767.280 },
    { x = 5.263,  y = 76.308, z = -757.192 },
    { x = 9.013,  y = 76.413, z = -722.767 },
    { x = 9.715,  y = 76.785, z = -744.856 },
    { x = 10.129, y = 65.914, z = -736.797 },
    { x = 10.238, y = 76.550, z = -724.555 },
    { x = 22.027, y = 76.512, z = -730.651 },
    { x = 26.127, y = 76.550, z = -767.194 },
    { x = 26.248, y = 76.607, z = -750.256 },
    { x = 35.687, y = 76.152, z = -757.707 },
    { x = 36.108, y = 76.590, z = -710.141 },
    { x = 38.753, y = 76.809, z = -771.376 },
    { x = 42.179, y = 76.290, z = -752.683 },
    { x = 46.836, y = 76.828, z = -758.276 },
    { x = 48.250, y = 76.524, z = -766.964 },
    { x = 49.704, y = 76.034, z = -722.611 },
    { x = 50.825, y = 76.781, z = -756.612 },
}

entity.onMobInitialize = function(mob)
    local spawnPoint = spawnPoints[math.randomInt(1, #spawnPoints)]
    mob:setSpawn(spawnPoint.x, spawnPoint.y, spawnPoint.z)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.CHARMABLE, 1)
    mob:setMobMod(xi.mobMod.SOUND_RANGE, 30)
    mob:setMobMod(xi.mobMod.ROAM_DISTANCE, 500)
    mob:setMobMod(xi.mobMod.ROAM_RATE, 10)
    mob:setRoamFlags(xi.roamFlag.WORM)
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        [1] = { xi.magic.spell.STONE_IV,    target, false, xi.action.type.DAMAGE_TARGET,        nil,                 0, 100 },
        [2] = { xi.magic.spell.STONEGA_III, target, false, xi.action.type.DAMAGE_TARGET,        nil,                 0, 100 },
        [3] = { xi.magic.spell.QUAKE,       target, false, xi.action.type.DAMAGE_TARGET,        nil,                 0, 100 },
        [4] = { xi.magic.spell.RASP,        target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.RASP,      0, 100 },
        [5] = { xi.magic.spell.BIND,        target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.BIND,      0, 100 },
        [6] = { xi.magic.spell.STONESKIN,   mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.STONESKIN, 0, 100 },
    }

    return xi.combat.behavior.chooseAction(mob, target, nil, spellList)
end

entity.onMobDespawn = function(mob)
    local spawnPoint = spawnPoints[math.randomInt(1, #spawnPoints)]
    mob:setSpawn(spawnPoint.x, spawnPoint.y, spawnPoint.z)
end

return entity
