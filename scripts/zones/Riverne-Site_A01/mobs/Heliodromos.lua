-----------------------------------
-- Area: Riverne - Site A01
--  Mob: Heliodromos
-----------------------------------
local ID = zones[xi.zone.RIVERNE_SITE_A01]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.TRIPLE_ATTACK, 15)
    mob:setMobMod(xi.mobMod.SUPERLINK, ID.mob.HELIODROMOS_OFFSET)

    local zone = mob:getZone()
    if zone then
        zone:setLocalVar('Heliodromos_Despawn', 0)
    end
end

entity.onMobRoam = function(mob)
    local zone = mob:getZone()
    if not zone then
        return
    end

    local heliodromosDespawn = zone:getLocalVar('Heliodromos_Despawn')
    if heliodromosDespawn == 0 then
        return
    end

    if heliodromosDespawn > GetSystemTime() then
        return
    end

    -- 10 minutes have passed since first heliodromos dies. despawn any remaining heliodromos.
    zone:setLocalVar('Heliodromos_Despawn', 0)

    -- Despawn heliodromos.
    for i = ID.mob.HELIODROMOS_OFFSET, ID.mob.HELIODROMOS_OFFSET + 2 do
        if GetMobByID(i):isSpawned() then
            DespawnMob(i)
        end
    end

    -- Allow placeholders to respawn.
    for i = ID.mob.HELIODROMOS_OFFSET - 3, ID.mob.HELIODROMOS_OFFSET - 1 do
        local ph = GetMobByID(i)

        if ph then
            DisallowRespawn(i, false)
            ph:setRespawnTime(GetMobRespawnTime(i))
        end
    end
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.WEIGHT, { power = 50 })
end

entity.onMobDeath = function(mob, player, optParams)
    -- One of the heliodromos was killed. set a 10 minute despawn timer before the others despawn
    if optParams.isKiller or optParams.noKiller then
        local zone = mob:getZone()
        if not zone then
            return
        end

        if zone:getLocalVar('Heliodromos_Despawn') == 0 then
            zone:setLocalVar('Heliodromos_Despawn', GetSystemTime() + 210)
        end
    end
end

entity.onMobDespawn = function(mob)
    for i = ID.mob.HELIODROMOS_OFFSET, ID.mob.HELIODROMOS_OFFSET + 2 do
        if GetMobByID(i):isAlive() then
            return
        end
    end

    local zone = mob:getZone()
    if not zone then
        return
    end

    zone:setLocalVar('Heliodromos_ToD', GetSystemTime() + math.randomInt(43200, 54000)) -- 12 to 15 hours

    -- Allow placeholders to respawn
    for i = ID.mob.HELIODROMOS_OFFSET - 3, ID.mob.HELIODROMOS_OFFSET - 1 do
        local ph = GetMobByID(i)

        if ph then
            DisallowRespawn(i, false)
            ph:setRespawnTime(GetMobRespawnTime(ph:getID()))
        end
    end
end

return entity
