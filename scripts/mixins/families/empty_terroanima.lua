-----------------------------------
--  Effect from the item Bottle of Terroanima --
-----------------------------------

require('scripts/globals/mixins')

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

local arenaHeights =
{
    [xi.zone.SPIRE_OF_DEM  ] = {  60, 0, -60 },
    [xi.zone.SPIRE_OF_HOLLA] = { -60, 0,  60 },
    [xi.zone.SPIRE_OF_MEA  ] = {  60, 0, -60 },
    [xi.zone.SPIRE_OF_VAHZL] = {  60, 0, -60 },
}

local function endSpireTerror(mob, terroanima)
    mob:setLocalVar('EmptyTerror', 0)
    if not terroanima.roamFlags then
        return
    end

    mob:clearPath()
    mob:setRoamFlags(terroanima.roamFlags)
    mob:setMobMod(xi.mobMod.NO_MOVE, terroanima.noMove)
    mob:setAutoAttackEnabled(true)
    mob:setMobAbilityEnabled(true)
    mob:setMagicCastingEnabled(true)
    terroanima.roamFlags  = nil
    terroanima.noMove     = nil
    terroanima.recovering = nil
end

local function doTerrorRun(mob)
    local terrorStart = mob:getLocalVar('EmptyTerror')
    local terrorDuration = mob:getLocalVar('EmptyTerrorDuration')
    if terrorStart ~= 0 then
        if terrorStart + terrorDuration < GetSystemTime() then
            mob:setLocalVar('EmptyTerror', 0)
            mob:setAutoAttackEnabled(true)
            mob:setMobAbilityEnabled(true)
            mob:setMagicCastingEnabled(true)
            mob:setRoamFlags(0)
        elseif terrorStart + terrorDuration > GetSystemTime() then
            if not mob:isFollowingPath() then
                mob:setRoamFlags(256, 512)
                mob:setAutoAttackEnabled(false)
                mob:setMobAbilityEnabled(false)
                mob:setMagicCastingEnabled(false)
                local pos = mob:getPos()
                mob:pathTo(pos.x + math.randomInt(-5, 5), pos.y, pos.z + math.randomInt(-5, 5), 9) -- Pathflags = 9 (xi.pathflag.run, xi.pathflag.scripted)
            end
        end
    end
end

local function doSpireTerrorRun(mob)
    local terrorStart = mob:getLocalVar('EmptyTerror')
    if terrorStart == 0 then
        return
    end

    local terroanima = mob:getData().terroanima
    if not terroanima then
        doTerrorRun(mob)
        return
    end

    if terrorStart + mob:getLocalVar('EmptyTerrorDuration') <= GetSystemTime() then
        endSpireTerror(mob, terroanima)
        return
    end

    if not terroanima.roamFlags then
        terroanima.roamFlags = mob:getRoamFlags()
        terroanima.noMove    = mob:getMobMod(xi.mobMod.NO_MOVE)
        mob:clearPath()
        mob:setRoamFlags(bit.bor(terroanima.roamFlags, xi.roamFlag.SCRIPTED))
        -- Scripted paths still run while NO_MOVE blocks ordinary chasing.
        mob:setMobMod(xi.mobMod.NO_MOVE, 1)
        mob:setAutoAttackEnabled(false)
        mob:setMobAbilityEnabled(false)
        mob:setMagicCastingEnabled(false)
    end

    local pos = mob:getPos()
    if (pos.x - terroanima.center.x) ^ 2 + (pos.z - terroanima.center.z) ^ 2 > 400 then
        if not terroanima.recovering then
            mob:clearPath()
            terroanima.recovering = true
        end

        if not mob:isFollowingPath() then
            mob:pathTo(terroanima.center.x, terroanima.center.y, terroanima.center.z, bit.bor(xi.pathflag.RUN, xi.pathflag.SCRIPT))
        end

        return
    end

    if mob:isFollowingPath() then
        return
    end

    terroanima.recovering = nil
    local zone        = mob:getZone()
    local destination = { x = pos.x, y = pos.y, z = pos.z }
    for _ = 1, 5 do
        destination.x = pos.x + math.randomInt(-5, 5)
        destination.z = pos.z + math.randomInt(-5, 5)

        if
            (destination.x - terroanima.center.x) ^ 2 + (destination.z - terroanima.center.z) ^ 2 <= 400 and
            zone:isNavigablePoint(destination)
        then
            mob:pathTo(destination.x, destination.y, destination.z, bit.bor(xi.pathflag.RUN, xi.pathflag.SCRIPT))
            return
        end
    end
end

g_mixins.families.empty_terroanima = function(emptyMob)
    if arenaHeights[emptyMob:getZoneID()] then
        emptyMob:addListener('SPAWN', 'EMPTY_TERROANIMA_SPAWN', function(mob)
            local heights     = arenaHeights[mob:getZoneID()]
            local battlefield = mob:getBattlefield()
            if not battlefield then
                return
            end

            local area = battlefield:getArea()
            if not heights[area] then
                return
            end

            mob:getData().terroanima =
            {
                center = { x = (area - 2) * 240, y = heights[area], z = 0 },
            }
        end)

        emptyMob:addListener('ROAM_TICK', 'EMPTY_TERROANIMA_RTICK', doSpireTerrorRun)
        emptyMob:addListener('COMBAT_TICK', 'EMPTY_TERROANIMA_CTICK', doSpireTerrorRun)
        emptyMob:addListener('DESPAWN', 'EMPTY_TERROANIMA_DESPAWN', function(mob)
            local terroanima = mob:getData().terroanima
            if terroanima then
                endSpireTerror(mob, terroanima)
                return
            end

            mob:setAutoAttackEnabled(true)
            mob:setMobAbilityEnabled(true)
            mob:setMagicCastingEnabled(true)
            mob:setRoamFlags(xi.roamFlag.NONE)
        end)

        return
    end

    emptyMob:addListener('ROAM_TICK', 'EMPTY_TERROANIMA_RTICK', function(mob)
        doTerrorRun(mob)
    end)

    emptyMob:addListener('COMBAT_TICK', 'EMPTY_TERROANIMA_CTICK', function(mob)
        doTerrorRun(mob)
    end)

    emptyMob:addListener('DESPAWN', 'EMPTY_TERROANIMA_DESPAWN', function(mob)
        mob:setAutoAttackEnabled(true)
        mob:setMobAbilityEnabled(true)
        mob:setMagicCastingEnabled(true)
        mob:setRoamFlags(0)
    end)
end

return g_mixins.families.empty_terroanima
