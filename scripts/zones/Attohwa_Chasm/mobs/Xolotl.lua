-----------------------------------
-- Area: Attohwa Chasm
--  Mob: Xolotl
-----------------------------------
---@type TMobEntity
local entity = {}
local isSummoning = false

local summonPet = function(mob, pet, spawnPos)
    if not pet or not mob then
        return
    end

    isSummoning = true
    -- Fake a Summoning animation
    mob:entityAnimationPacket(xi.animationString.CAST_SUMMONER_START)
    mob:timer(5000, function(mob)
        mob:entityAnimationPacket(xi.animationString.CAST_SUMMONER_STOP)
        pet:setSpawn(spawnPos.x + 2, spawnPos.y, spawnPos.z, spawnPos.rot)
        pet:spawn()
        if mob:isEngaged() then
            pet:updateEnmity(mob:getTarget())
        end
        pet:follow(mob, xi.followType.ROAM)
        isSummoning = false
    end)
end

local handlePetCooldown = function(mob)
    local xolotlID = mob:getID()

    if not GetMobByID(xolotlID + 1):isSpawned() and not isSummoning then
        if GetSystemTime() >= mob:getLocalVar("[XOLOTL]HoundCooldown") then
            summonPet(mob, GetMobByID(xolotlID + 1), mob:getPos())
        end
    end

    if not GetMobByID(xolotlID + 2):isSpawned() and not isSummoning then
        if GetSystemTime() >= mob:getLocalVar("[XOLOTL]SacrificeCooldown") then
            summonPet(mob, GetMobByID(xolotlID + 2), mob:getPos())
        end
    end
end

local handleGroupAggro = function(xolotlID)
    -- This function needs the Xolotl ID as mobid to loop through the group
    local pickedTarget -- find the best suitable attack target, prioritizing Xolotl's target

    for i = xolotlID + 2, xolotlID, -1 do
        local mob = GetMobByID(i)
        if mob and mob:getTarget() then
            if mob:getTarget():isPC() then
                pickedTarget = mob:getTarget()
            end
        end
    end

    -- If Xolotl or pet are roaming, but any of the others have PC target, update enmity to the picked target
    for i = xolotlID, xolotlID + 2 do
        local mob = GetMobByID(i)
        if pickedTarget and mob and mob:getCurrentAction() == xi.act.ROAMING then
            mob:updateEnmity(pickedTarget)
        end
    end
end

entity.onMobSpawn = function(mob)
    mob:setRespawnTime(0)
    mob:setMobMod(xi.mobMod.SUPERLINK, 32)
end

entity.onMobRoam = function(mob)
    handlePetCooldown(mob)
    handleGroupAggro(mob:getID())
end

entity.onMobFight = function(mob)
    handlePetCooldown(mob)
    handleGroupAggro(mob:getID())
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.XOLOTL_XTRAPOLATOR)
end

entity.onMobDespawn = function(mob)
    -- Do not respawn Xolotl for 21-24 hours
    mob:setRespawnTime(math.random(75600, 86400))
end

return entity
