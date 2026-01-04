-----------------------------------
--- Zdei Family Mixin
--  https://ffxiclopedia.fandom.com/wiki/Category:Zdei
--  https://www.bg-wiki.com/ffxi/Category:Zdei
--
--  Zdei swap forms every 60 seconds, the swap appears random between Bars, Rings, and Pot.
--
--  Animation Sub 0 Pot Form
--  Animation Sub 1 Pot Form (reverse eye position)
--  Animation Sub 2 Bar Form
--  Animation Sub 3 Ring Form
-----------------------------------
require('scripts/globals/mixins')
-----------------------------------

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

g_mixins.families.zdei = function(zdeiMob)
    -- Assign rotation speed and direction based off of pools
    local rotationPools =
    {
        [xi.mobPool.EOZDEI_LEFT]   = -16,
        [xi.mobPool.EOZDEI_RIGHT]  =  16,
        [xi.mobPool.AWZDEI_LEFT]   = -16,
        [xi.mobPool.AWZDEI_RIGHT]  =  16,
        [xi.mobPool.AWZDEI_FAST_L] = -32,
        [xi.mobPool.AWZDEI_FAST_R] =  32,
    }

    zdeiMob:addListener('SPAWN', 'ZDEI_SPAWN', function(mob)
        mob:setAnimationSub(0)
        mob:addMod(xi.mod.MDEF, 20) -- Zdei have innate +20 MDEF

        -- Store the rotation offset for use in onPath
        local poolId = mob:getPool()
        if rotationPools[poolId] then
            local rotOffset = rotationPools[poolId]
            mob:setLocalVar('zdeiRotationOffset', rotOffset)
        end
    end)

    zdeiMob:addListener('ENGAGE', 'ZDEI_ENGAGE', function(mob, target)
        mob:setAnimationSub(1)
        mob:setLocalVar('changeTime', GetSystemTime() + math.random(15, 30))
    end)

    zdeiMob:addListener('DISENGAGE', 'ZDEI_DISENGAGE', function(mob)
        mob:setAnimationSub(0)
        mob:setLocalVar('changeTime', 0)
    end)

    zdeiMob:addListener('COMBAT_TICK', 'ZDEI_CTICK', function(mob)
        local changeTime = mob:getLocalVar('changeTime')
        local now = GetSystemTime()

        -- Change to a new mode if time has expired and not currently charging optic induration
        if
            now >= changeTime and
            mob:getCurrentAction() == xi.action.category.BASIC_ATTACK and
            mob:getLocalVar('chargeCount') == 0
        then
            local newSub = math.random(1, 3)
            while newSub == mob:getAnimationSub() do
                newSub = math.random(1, 3)
            end

            mob:setAnimationSub(newSub)
            mob:setLocalVar('changeTime', now + 60)
        end
    end)
end

return g_mixins.families.zdei
