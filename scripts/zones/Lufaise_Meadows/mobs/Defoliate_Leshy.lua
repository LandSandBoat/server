-----------------------------------
-- Area: Lufaise Meadows
--  Mob: Defoliate Leshy
-----------------------------------
local ID = zones[xi.zone.LUFAISE_MEADOWS]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller then
        GetMobByID(mob:getID()-1):setLocalVar('timeToGrow', GetSystemTime() + math.randomInt(43200, 86400)) -- Colorful in 12 to 24 hours
    end
end

entity.onMobDespawn = function(mob)
    local phIndex = mob:getLocalVar('phIndex')

    -- Defoliate Leshy can spawn outside of the grow system with no placeholder index, so pick one at random.
    if
        phIndex < ID.mob.LESHY_OFFSET or
        phIndex > ID.mob.LESHY_OFFSET + 7
    then
        phIndex = ID.mob.LESHY_OFFSET + math.randomInt(0, 7)
    end

    local ph = GetMobByID(phIndex)

    -- allow the placeholder to respawn
    if ph then
        DisallowRespawn(mob:getID(), true)
        DisallowRespawn(phIndex, false)
        ph:setRespawnTime(GetMobRespawnTime(phIndex))
    end
end

return entity
