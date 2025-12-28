-----------------------------------
-- Area: Wajaom Woodlands
--  Mob: Zoraal Ja's Pkuucha
-----------------------------------
mixins = { require('scripts/mixins/families/colibri_mimic') }
-----------------------------------
local ID = zones[xi.zone.WAJAOM_WOODLANDS]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.ZORAAL_JAS_PKUUCHA - 6] = ID.mob.ZORAAL_JAS_PKUUCHA, -- 181.000 -18.000 -63.000
    [ID.mob.ZORAAL_JAS_PKUUCHA - 5] = ID.mob.ZORAAL_JAS_PKUUCHA, -- 181.000 -19.000 -77.000
    [ID.mob.ZORAAL_JAS_PKUUCHA - 4] = ID.mob.ZORAAL_JAS_PKUUCHA, -- 195.000 -18.000 -95.000
    [ID.mob.ZORAAL_JAS_PKUUCHA - 3] = ID.mob.ZORAAL_JAS_PKUUCHA, -- 220.000 -19.000 -80.000
    [ID.mob.ZORAAL_JAS_PKUUCHA - 2] = ID.mob.ZORAAL_JAS_PKUUCHA, -- 219.000 -18.000 -59.000
    [ID.mob.ZORAAL_JAS_PKUUCHA - 1] = ID.mob.ZORAAL_JAS_PKUUCHA, -- 203.000 -16.000 -74.000
}

entity.spawnPoints =
{
    { x = 193.000, y = -18.000, z = -65.000 },
    { x = 221.000, y = -19.000, z = -75.000 },
    { x = 207.000, y = -16.000, z = -77.000 },
    { x = 181.000, y = -18.000, z = -42.000 },
    { x = 170.000, y = -18.000, z = -21.000 },
}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
end

-- Chooses the HP percentage at which to spawn Percipient Zoraal Ja
entity.onMobSpawn = function(mob)
    mob:setLocalVar('whenToPopZoraal', math.random(20, 50))
    mob:setLocalVar('hasPoppedZoraal', 0)
    mob:setUnkillable(true)
end

-- Despawns Percipient Zoraal Ja on disengage and resets the local var
entity.onMobDisengage = function(mob)
    mob:setLocalVar('hasPoppedZoraal', 0)
    if GetMobByID(ID.mob.PERCIPIENT_ZORAAL_JA):isSpawned() then
        DespawnMob(ID.mob.PERCIPIENT_ZORAAL_JA)
    end
end

-- Despawns Percipient Zoraal Ja on roam and resets the local var
entity.onMobRoam = function(mob)
    mob:setLocalVar('hasPoppedZoraal', 0)
    if GetMobByID(ID.mob.PERCIPIENT_ZORAAL_JA):isSpawned() then
        DespawnMob(ID.mob.PERCIPIENT_ZORAAL_JA)
    end
end

-- When Zoraal Ja's Pkuucha reaches the set HP %, spawn Percipient Zoraal Ja,
-- fully heal Zoraal Ja's Pkuucha and set a local var to prevent multiple spawn attempts
-- When Percipient Zoraal Ja dies, Zoraal Ja's Pkuucha becomes killable again
entity.onMobFight = function(mob, target)
    if
        mob:getHPP() <= mob:getLocalVar('whenToPopZoraal') and
        not GetMobByID(ID.mob.PERCIPIENT_ZORAAL_JA):isSpawned() and
        mob:getLocalVar('hasPoppedZoraal') == 0
    then
        GetMobByID(ID.mob.PERCIPIENT_ZORAAL_JA):setSpawn(mob:getXPos() + math.random(-2, 2), mob:getYPos(), mob:getZPos() + math.random(-2, 2))
        SpawnMob(ID.mob.PERCIPIENT_ZORAAL_JA):updateEnmity(target)
        mob:setHP(mob:getMaxHP())
        mob:setLocalVar('hasPoppedZoraal', 1)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 447)
end

return entity
