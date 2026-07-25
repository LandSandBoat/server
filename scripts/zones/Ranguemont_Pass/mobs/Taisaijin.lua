-----------------------------------
-- Area: Ranguemont Pass
--   NM: Taisaijin
-----------------------------------
local ID = zones[xi.zone.RANGUEMONT_PASS]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:setMobMod(xi.mobMod.ALWAYS_AGGRO, 1)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.PARALYZE_RES_RANK, 9)
    mob:setMod(xi.mod.SLOW_RES_RANK, 9)
    mob:setMod(xi.mod.SILENCE_RES_RANK, 9)
    mob:setMod(xi.mod.POISON_RES_RANK, 9)
    mob:setMod(xi.mod.BLIND_RES_RANK, 9)
end

entity.onMobDeath = function(mob, player, optParams)
    if player then
        player:addTitle(xi.title.BYE_BYE_TAISAI)
    end
end

entity.onMobDespawn = function(mob)
    local phIndex = mob:getLocalVar('phIndex')

    -- Taisaijin can spawn outside of the grow system with no placeholder index, so pick one at random.
    if
        phIndex < 1 or
        phIndex > 3
    then
        phIndex = math.randomInt(1, 3)
    end

    local currentPH = GetMobByID(ID.mob.TAISAIJIN - phIndex)

    -- allow current placeholder to respawn
    if currentPH then
        DisallowRespawn(mob:getID(), true)
        DisallowRespawn(ID.mob.TAISAIJIN - phIndex, false)
        currentPH:setRespawnTime(GetMobRespawnTime(ID.mob.TAISAIJIN - phIndex))
    end

    -- pick next placeholder
    phIndex = (phIndex % 3) + 1
    local nextPH  = GetMobByID(ID.mob.TAISAIJIN - phIndex)

    if nextPH then
        nextPH:setLocalVar('timeToGrow', GetSystemTime() + math.randomInt(86400, 259200)) -- 1 to 3 days
        nextPH:setLocalVar('phIndex', phIndex)
    end
end

return entity
