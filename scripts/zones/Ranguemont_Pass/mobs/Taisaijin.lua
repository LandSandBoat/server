-----------------------------------
-- Area: Ranguemont Pass
--   NM: Taisaijin
-----------------------------------
local ID = zones[xi.zone.RANGUEMONT_PASS]
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.BYE_BYE_TAISAI)
end

entity.onMobDespawn = function(mob)
    local phIndex = mob:getLocalVar('phIndex')
    local ph = GetMobByID(ID.mob.TAISAIJIN_PH[phIndex])

    -- allow current placeholder to respawn
    DisallowRespawn(mob:getID(), true)
    DisallowRespawn(ph:getID(), false)
    ph:setRespawnTime(GetMobRespawnTime(ph:getID()))

    -- pick next placeholder
    phIndex = (phIndex % 3) + 1
    ph = GetMobByID(ID.mob.TAISAIJIN_PH[phIndex])
    ph:setLocalVar('timeToGrow', os.time() + math.random(86400, 259200)) -- 1 to 3 days
    ph:setLocalVar('phIndex', phIndex)
end

return entity
