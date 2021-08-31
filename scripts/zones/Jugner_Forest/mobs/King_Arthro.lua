-----------------------------------
-- Area: Jugner Forest
--   NM: King Arthro
-----------------------------------
mixins =
{
    require("scripts/mixins/job_special"),
    require("scripts/mixins/rage")
}
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onMobSpawn = function(mob)
    local KingArthroID = mob:getID()

    -- Use King Arthro ID to determine Knight Crab Id's, then set their respawn to 0 so they don't spawn while KA is up
    for offset = 1, 10 do
        GetMobByID(KingArthroID - offset):setRespawnTime(0)
    end
end

entity.onAdditionalEffect = function(mob, target, damage)
    if mob:hasStatusEffect(xi.effect.ENWATER) then
        return 0, 0, 0
    else
        return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.PARALYZE)
    end
end

entity.onMonsterMagicPrepare = function(mob, target)
    -- Instant cast on spells - Waterga IV, Poisonga II, Drown, and Enwater
    local rnd = math.random()

    if rnd < 0.2 then
        return 202 -- Waterga IV
    elseif rnd < 0.6 then
        return 226 -- Poisonga II
    elseif rnd < 0.8 then
        return 240 -- Drown
    else
        return 105 -- Enwater
    end
end

entity.onMobDeath = function(mob, player, isKiller)
end

entity.onMobDespawn = function(mob)
    local KingArthroID = mob:getID()

    GetMobByID(KingArthroID):setLocalVar("[POP]King_Arthro", 0)

    -- Set respawn of 21:05 to 24:05
    local respawnTime = 75900 + math.random(0, 6) * 1800 -- 21:05 to 24:05 respawn timer in 30 minute intervals
    for offset = 1, 10 do
        GetMobByID(KingArthroID - offset):setRespawnTime(respawnTime)
    end
end

return entity
