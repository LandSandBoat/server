-----------------------------------
-- Area: Riverne - Site B01
-- Mob: Spell Spitter Spilospok
-- Type: WAR
-- Note: NM for quest Go! Go! Gobmuffin!
-- Note: Set to sub RDM so it has MP for the player to aspir. Total MP/Refresh is unknown
-- TODO: Test if the NM runs out of MP, from captures it does not appear to but it was not specifically tested
-----------------------------------
local ID = zones[xi.zone.RIVERNE_SITE_B01]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180) -- 3 minutes
    mob:setMobMod(xi.mobMod.ALWAYS_AGGRO, 1)
    mob:setMobMod(xi.mobMod.DETECTION, bit.bor(xi.detects.SIGHT, xi.detects.HEARING)) -- NM aggros to sound+sight
    mob:setMobMod(xi.mobMod.SOUND_RANGE, 20) -- 20 Yalms
    mob:setMobMod(xi.mobMod.SUPERLINK, ID.mob.SPELL_SPITTER_SPILUSPOK + 1)
    mob:setMobMod(xi.mobMod.SUPERLINK, ID.mob.SPELL_SPITTER_SPILUSPOK + 2)
    mob:setMod(xi.mod.REFRESH, 5)
    mob:addStatusEffectEx(xi.effect.STUN, xi.effect.STUN, 0, 0, 1, 0, 0, 0, xi.effectFlag.NO_LOSS_MESSAGE, true) -- Holds the mob so the player can zone in before they "ambush" the player
end

-- When the NM is back at spawn it will rotate to face the portal before standing there until agro/despawn
entity.onMobRoam = function(mob)
    local spawnPos  = mob:getSpawnPos()
    local spawnDist = mob:checkDistance(spawnPos.x, spawnPos.y, spawnPos.z)

    if spawnDist <= 1 then
        mob:setRotation(spawnPos.rot)
        mob:setMobMod(xi.mobMod.ROAM_DISTANCE, 0)
    end
end

-- Failsafe incase the player reengages/agros as the NM is pathing back to spawn
entity.onMobEngage = function(mob)
    mob:clearPath()
end

-- Sends the NM back to it's spawn location to ambush the next player to come through the portal
entity.onMobDisengage = function(mob)
    local spawnPos  = mob:getSpawnPos()
    local spawnDist = mob:checkDistance(spawnPos.x, spawnPos.y, spawnPos.z)

    if spawnDist >= 1 then
        mob:pathTo(spawnPos.x, spawnPos.y, spawnPos.z, bit.bor(xi.path.flag.SCRIPT))
    end
end

return entity
