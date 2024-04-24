-----------------------------------
-- Area: Jade Sepulcher
--  Mob: Phantom Puk
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
end

entity.onMobFight = function(mob, target)
    local battleTime   = mob:getLocalVar('battleTime')
    local boreasMantle = 1980

    if os.time() > battleTime + 60 then
        -- Reset our timer
        mob:setLocalVar('battleTime', os.time())
        mob:useMobAbility(boreasMantle)
    end
end

entity.onMobEngage = function(mob, target)
    mob:setLocalVar('battleTime', os.time())
end

entity.onMobDeath = function(mob, player, optParams)
    local phantomPuk = mob:getID()

    for i = 1, 4 do
        DespawnMob(phantomPuk + i)
    end
end

return entity
