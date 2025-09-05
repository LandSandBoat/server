-----------------------------------
-- Area: Ilrusi Atoll (Extermination)
--  Mob: Carrion Toad
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

    local toadMob  = GetMobByID(ID.UNDEAD_MOBS + 3, instance)
    local randVal  = math.random(1, 5)

    if
        randVal == 1 and
        toadMob and
        toadMob:getLocalVar('ToadSpawned') == 0
    then
        SpawnMob(toadMob:getID(), instance)
        toadMob:setLocalVar('ToadSpawned', 1)
    else
        instance:setProgress(instance:getProgress() + 1)
    end
end

return entity
