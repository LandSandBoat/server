-----------------------------------
-- Area: Ilrusi Atoll (Extermination)
--  Mob: Carrion Leech
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

    local leechMob = GetMobByID(ID.UNDEAD_MOBS + 1, instance)
    local randVal  = math.random(1, 5)

    if
        randVal == 1 and
        leechMob and
        leechMob:getLocalVar('LeechSpawned') == 0
    then
        SpawnMob(leechMob:getID(), instance)
        leechMob:setLocalVar('LeechSpawned', 1)
    else
        instance:setProgress(instance:getProgress() + 1)
    end
end

return entity
