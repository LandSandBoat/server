-----------------------------------
-- Area: North Gustaberg [S]
--   NM: Olgoi-Khorkhoi
-- https://www.bg-wiki.com/ffxi/Olgoi-Khorkhoi
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = 318.836, y = -30.032, z = 1059.678 },
    { x = 325.058, y = -30.335, z = 1070.703 },
    { x = 306.609, y = -27.978, z = 1076.948 },
    { x = 309.911, y = -28.852, z = 1073.993 },
    { x = 313.410, y = -30.970, z = 1058.780 },
    { x = 321.457, y = -30.000, z = 1078.293 },
}

entity.onMobInitialize = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(math.random(5400, 7200))

    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.PETRIFY)
end

entity.onMobSpawn = function(mob)
    -- Olgoi gains TP in 5 hits consistently at low HP, so it is probably ~200TP a hit.
    -- but does not have regain
    mob:setMod(xi.mod.STORETP, 170)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 15)
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        xi.magic.spell.STONE_II,
        xi.magic.spell.STONEGA,
    }

    return spellList[math.random(1, #spellList)]
end

entity.onMobMobskillChoose = function(mob, target)
    return xi.mobSkill.SANDSPIN -- Sandspin is only TP move
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 499)
end

entity.onMobDespawn = function(mob)
    -- Sets to respawn between 90 to 120 minutes
    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(math.random(5400, 7200))
end

return entity
