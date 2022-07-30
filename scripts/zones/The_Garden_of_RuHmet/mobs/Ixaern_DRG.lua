-----------------------------------
-- Area: The Garden of Ru'Hmet
--  Mob: Ix'aern DRG
-----------------------------------
local ID = require("scripts/zones/The_Garden_of_RuHmet/IDs")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    local mobId = mob:getID()
    local x = mob:getXPos()
    local y = mob:getYPos()
    local z = mob:getZPos()
    mob:useMobAbility(626) -- 2hr animation since wynavs aren't spawned via CallWyvern Ability
    for i = mobId + 1, mobId + 3 do
        local wynav = GetMobByID(i)
        wynav:setSpawn(x + math.random(-2, 2), y, z + math.random(-2, 2))
        wynav:spawn()
    end
end

entity.onMobFight = function(mob, target)
    local mobId = mob:getID()
    local x = mob:getXPos()
    local y = mob:getYPos()
    local z = mob:getZPos()
    local changeTime = mob:getLocalVar("changeTime")
    local battleTime = mob:getBattleTime()

    for i = mobId + 1, mobId + 3 do
        local wynav = GetMobByID(i)
        if
            not wynav:isSpawned() and
            utils.canUseAbility(mob) == true
        then
            local repopWynavs = wynav:getLocalVar("repop") -- see Wynav script
            if mob:getBattleTime() - repopWynavs > 10 then
                wynav:setSpawn(x + math.random(-2, 2), y, z + math.random(-2, 2))
                mob:useMobAbility(626) -- 2hr animation since wynavs aren't spawned via CallWyvern Ability
                wynav:spawn()
                wynav:updateEnmity(target)
            end
        end
    end

    if
        mob:getAnimationSub() <= 1 and
        battleTime - changeTime > 60
    then -- goes into bracer mode for 30 seconds, every 60 seconds.
        mob:setAnimationSub(2) -- bracer mode
        mob:setMod(xi.mod.DELAY, 1000) -- increase speed in bracer mode
        mob:addMod(xi.mod.ATTP, 25)
        mob:setLocalVar("changeTime", battleTime)
    elseif
        mob:getAnimationSub() == 2 and
        battleTime - changeTime > 30
    then
        mob:setAnimationSub(1)
        mob:setMod(xi.mod.DELAY, 0) -- back to normal attack speed
        mob:delMod(xi.mod.ATTP, 25)
        mob:setLocalVar("changeTime", battleTime)
    end

end

entity.onMobEngaged = function(mob, target)
    local mobId = mob:getID()

    mob:setLocalVar("changeTime", 0)
    for i = mobId + 1, mobId + 3 do -- Wynavs share hate with Ix'DRG
        GetMobByID(i):updateEnmity(target)
    end
end

entity.onMobDeath = function(mob, player, isKiller)
    -- despawn pets
    local mobId = mob:getID()
    for i = mobId + 1, mobId + 3 do
        if GetMobByID(i):isSpawned() then
            DespawnMob(i)
        end
    end
end

entity.onMobDespawn = function( mob )
    -- despawn pets
    local mobId = mob:getID()
    for i = mobId + 1, mobId + 3 do
        if GetMobByID(i):isSpawned() then
            DespawnMob(i)
        end
    end

    -- Pick a new PH for Ix'Aern (DRG)
    local groups = ID.mob.AWAERN_DRG_GROUPS
    SetServerVariable("[SEA]IxAernDRG_PH", groups[math.random(1, #groups)] + math.random(0, 2))
end

return entity
