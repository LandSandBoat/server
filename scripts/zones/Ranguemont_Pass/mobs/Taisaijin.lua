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
    local ph = GetMobByID(ID.mob.TAISAIJIN_PH[phIndex])

    -- allow current placeholder to respawn
    if ph then
        DisallowRespawn(mob:getID(), true)
        DisallowRespawn(ph:getID(), false)
        ph:setRespawnTime(GetMobRespawnTime(ph:getID()))
    end

    -- pick next placeholder
    phIndex = (phIndex % 3) + 1
    ph = GetMobByID(ID.mob.TAISAIJIN_PH[phIndex])

    if ph then
        ph:setLocalVar('timeToGrow', GetSystemTime() + math.random(86400, 259200)) -- 1 to 3 days
        ph:setLocalVar('phIndex', phIndex)
    end
end

return entity
