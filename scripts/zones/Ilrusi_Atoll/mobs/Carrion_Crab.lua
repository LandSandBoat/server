-----------------------------------
-- Area: Ilrusi Atoll (Extermination)
--  Mob: Carrion Crab
-----------------------------------
local ID = zones[xi.zone.ILRUSI_ATOLL].mob[xi.assault.mission.EXTERMINATION]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    local instance = mob:getInstance()
    if not instance then
        return
    end

    local crabMob  = GetMobByID(ID.UNDEAD_MOBS, instance)
    local randVal  = math.random(1, 5)

    if
        randVal == 1 and
        crabMob and
        crabMob:getLocalVar('CrabSpawned') == 0
    then
        SpawnMob(crabMob:getID(), instance)
        crabMob:setLocalVar('CrabSpawned', 1)
    else
        instance:setProgress(instance:getProgress() + 1)
    end
end

return entity
