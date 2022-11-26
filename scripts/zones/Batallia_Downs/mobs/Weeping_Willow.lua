-----------------------------------
-- Area: Batallia Downs
--  Mob: Weeping Willow
-----------------------------------
local entity = {}

entity.onMobFight = function(mob, target)
    if mob:getHPP() <= 50 and mob:getLocalVar("Saplings") < 1 then
        SpawnMob(mob:getID() + 1):updateEnmity(target)
        SpawnMob(mob:getID() + 2):updateEnmity(target)
        SpawnMob(mob:getID() + 3):updateEnmity(target)
        SpawnMob(mob:getID() + 4):updateEnmity(target)
        SpawnMob(mob:getID() + 5):updateEnmity(target)
        mob:setLocalVar("Saplings", 1)
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    local lumberJackID = mob:getID() + 6
    -- Retail behavior is for it to walk back to where willow died if unclaimed *unless* willow was pulled down the cliff
    -- In that case, it will walk back near where Willow was spawned at.
    GetMobByID(lumberJackID):setSpawn(mob:getXPos(), mob:getYPos(), mob:getZPos())
    SpawnMob(lumberJackID)
end

return entity
