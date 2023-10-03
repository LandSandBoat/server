-----------------------------------
--  Effect from the item Bottle of Terroanima --
-----------------------------------

require('scripts/globals/mixins')

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

local function doTerrorRun(mob)
    local terrorStart = mob:getLocalVar('EmptyTerror')
    local terrorDuration = mob:getLocalVar('EmptyTerrorDuration')
    if terrorStart ~= 0 then
        if terrorStart + terrorDuration < os.time() then
            mob:setLocalVar('EmptyTerror', 0)
            mob:setAutoAttackEnabled(true)
            mob:setMobAbilityEnabled(true)
            mob:setMagicCastingEnabled(true)
            mob:setRoamFlags(0)
        elseif terrorStart + terrorDuration > os.time() then
            if not mob:isFollowingPath() then
                mob:setRoamFlags(256, 512)
                mob:setAutoAttackEnabled(false)
                mob:setMobAbilityEnabled(false)
                mob:setMagicCastingEnabled(false)
                local pos = mob:getPos()
                mob:pathTo(pos.x + math.random(-5, 5), pos.y, pos.z + math.random(-5, 5), 9) -- Pathflags = 9 (xi.pathflag.run, xi.pathflag.scripted)
            end
        end
    end
end

g_mixins.families.empty_terroanima = function(emptyMob)
    emptyMob:addListener('ROAM_TICK', 'EMPTY_TERROANIMA_RTICK', function(mob)
        doTerrorRun(mob)
    end)

    emptyMob:addListener('COMBAT_TICK', 'EMPTY_TERROANIMA_CTICK', function(mob)
        doTerrorRun(mob)
    end)

    emptyMob:addListener('DEATH', 'EMPTY_TERROANIMA_DEATH', function(mob)
        mob:setRoamFlags(0)
    end)
end

return g_mixins.families.empty_terroanima
