-----------------------------------
-- Area: Zhayolm Remnants
-- MOB: Poroggo Madame
-----------------------------------
local ID = zones[xi.zone.ZHAYOLM_REMNANTS]
-----------------------------------

---@type TMobEntity
local entity = {}

local elementMods =
{
    [1] = { null = xi.mod.FIRE_NULL,  res = xi.mod.FIRE_RES_RANK },
    [2] = { null = xi.mod.EARTH_NULL, res = xi.mod.EARTH_RES_RANK },
    [3] = { null = xi.mod.WATER_NULL, res = xi.mod.WATER_RES_RANK },
    [4] = { null = xi.mod.WIND_NULL,  res = xi.mod.WIND_RES_RANK },
    [5] = { null = xi.mod.ICE_NULL,   res = xi.mod.ICE_RES_RANK },
    [6] = { null = xi.mod.LTNG_NULL,  res = xi.mod.THUNDER_RES_RANK },
    [7] = { null = xi.mod.LIGHT_NULL, res = xi.mod.LIGHT_RES_RANK },
    [8] = { null = xi.mod.DARK_NULL,  res = xi.mod.DARK_RES_RANK },
}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:setMobMod(xi.mobMod.DETECTION, xi.detects.SIGHT)
end

entity.onMobSpawn = function(mob)
    local instance = mob:getInstance()

    if instance then
        local enteringDay = instance:getLocalVar('dayElement')
        -- nulls out dmg taken on the particular day
        -- also prevents enfeebs
        mob:addMod(elementMods[enteringDay].null, 100)
        mob:addMod(elementMods[enteringDay].res, -3)
        mob:addMod(xi.mod.SPELLINTERRUPT, -20)
        if enteringDay == xi.day.DARKSDAY then -- takes double dmg on Darksday
            mob:addMod(xi.mod.UDMGPHYS, 100)
            mob:addMod(xi.mod.UDMGBREATH, 100)
            mob:addMod(xi.mod.UDMGMAGIC, 1000)
            mob:addMod(xi.mod.UDMGRANGE, 100)
        end

        -- first floor madames are bigger
        if instance:getStage() == 1 then
            --mob:setEntitySize(xi.entitySize.LARGE)
            mob:setMobMod(xi.mobMod.MAGIC_COOL, 40)
            mob:setDelay(200)
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        local instance = mob:getInstance()

        if instance then
            instance:setLocalVar('killedNMs', instance:getLocalVar('killedNMs') + 1)

            if instance:getStage() == 2 then
                xi.salvage.handleSocketCells(mob, player)
            elseif mob:getID() == ID.mob.POROGGO_MADAME[4] then
                mob:setDropID(0)
                xi.salvage.spawnTempChest(mob, { rate = 1000 })
            end
        end
    end
end

return entity
