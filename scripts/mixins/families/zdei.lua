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

    zdeiMob:addListener('WEAPONSKILL_STATE_EXIT', 'ZDEI_WS_EXIT', function(mob, skillID)
        if skillID == xi.mobSkill.OPTIC_INDURATION_CHARGE then
            local chargeCount = mob:getLocalVar('chargeCount')
            local chargeTotal = mob:getLocalVar('chargeTotal')

            if chargeTotal > 0 and chargeCount == chargeTotal then
                mob:useMobAbility(xi.mobSkill.OPTIC_INDURATION, mob:getTarget())
            else
                if chargeCount == 0 then
                    mob:setAutoAttackEnabled(false)
                    mob:setMagicCastingEnabled(false)
                    mob:setLocalVar('chargeTotal', math.random(3, 5))
                end

                chargeCount = chargeCount + 1
                mob:setLocalVar('chargeCount', chargeCount)
                mob:useMobAbility(xi.mobSkill.OPTIC_INDURATION_CHARGE)
            end

        elseif skillID == xi.mobSkill.OPTIC_INDURATION then
            mob:setAutoAttackEnabled(true)
            mob:setMagicCastingEnabled(true)
            mob:setLocalVar('chargeCount', 0)
            mob:setLocalVar('chargeTotal', 0)
        end
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
