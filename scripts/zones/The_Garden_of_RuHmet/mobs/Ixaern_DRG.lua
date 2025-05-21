-----------------------------------
-- Area: The Garden of Ru'Hmet
--  Mob: Ix'aern DRG
-----------------------------------
local ID = zones[xi.zone.THE_GARDEN_OF_RUHMET]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
end

entity.onMobFight = function(mob, target)
    -- Spawn the pets if they are despawned
    -- TODO: summon animations?
    local mobId = mob:getID()
    local x = mob:getXPos()
    local y = mob:getYPos()
    local z = mob:getZPos()

    for i = mobId + 1, mobId + 3 do
        local wynav = GetMobByID(i)
        if wynav and not wynav:isSpawned() then
            local repopWynavs = wynav:getLocalVar('repop') -- see Wynav script
            if mob:getBattleTime() - repopWynavs > 10 then
                wynav:setSpawn(x + math.random(1, 5), y, z + math.random(1, 5))
                wynav:spawn()
                wynav:updateEnmity(target)
            end
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
    -- despawn pets
    local mobId = mob:getID()
    for i = mobId + 1, mobId + 3 do
        if GetMobByID(i):isSpawned() then
            DespawnMob(i)
        end
    end
end

entity.onMobDespawn = function(mob)
    -- despawn pets
    local mobId = mob:getID()
    for i = mobId + 1, mobId + 3 do
        if GetMobByID(i):isSpawned() then
            DespawnMob(i)
        end
    end

    -- Pick a new PH for Ix'Aern (DRG)
    local groups = ID.mob.AWAERN_DRG_GROUPS
    SetServerVariable('[SEA]IxAernDRG_PH', groups[math.random(1, #groups)] + math.random(0, 2))
end

return entity
