-----------------------------------
-- Area: Hazhalm Testing Grounds
--   NM: Hildesvini (Einherjar)
-- Notes: Spawns 3 Djiggas after each TP move.
-- Prefers Proboscis Shower if any Djigga is alive.
-----------------------------------
mixins =
{
    require('scripts/mixins/draw_in'),
}
local DJIGGAS = zones[xi.zone.HAZHALM_TESTING_GROUNDS].mob.DJIGGA_HILDESVINI
-----------------------------------
---@type TMobEntity
local entity = {}

local function despawnDjiggas()
    utils.each(DJIGGAS, function(_, mobId)
        local djigga = GetMobByID(mobId)
        if djigga and djigga:isSpawned() then
            DespawnMob(mobId)
        end
    end)
end

entity.onMobInitialize = function(mob)
    xi.einherjar.onBossInitialize(mob)
end

entity.onMobSpawn = function(mob)
    despawnDjiggas()
end

entity.onMobMobskillChoose = function(mob, target)
    local anyAlive = utils.any(DJIGGAS, function(_, mobId)
        local djigga = GetMobByID(mobId)
        if djigga and djigga:isAlive() then
            return true
        end
    end)

    if anyAlive then
        return xi.mobSkill.PROBOSCIS_SHOWER
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)
    local chamberData = xi.einherjar.getChamber(mob:getLocalVar('[ein]chamber'))

    local freeIds = utils.filterArray(DJIGGAS, function(_, mobId)
        local djigga = GetMobByID(mobId)
        if djigga and not djigga:isSpawned() then
            return true
        end

        return false
    end)

    for i = 1, math.min(3, #freeIds) do
        local djigga = GetMobByID(freeIds[i])
        if djigga and not djigga:isSpawned() then
            djigga:setSpawn(mob:getXPos() + i, mob:getYPos(), mob:getZPos(), mob:getRotPos())
            if chamberData then
                xi.einherjar.spawnMob(djigga, 3, chamberData)
            else -- fallback for testing with no einherjar context
                djigga:spawn()
            end

            djigga:updateEnmity(target)
        end
    end
end

entity.onMobDespawn = function(mob)
    despawnDjiggas()
end

return entity
