-- Chigoe family mixin

require('scripts/globals/mixins')

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

g_mixins.families.chigoe = function(chigoe)
    chigoe:addListener('SPAWN', 'CHIGOE_SPAWN', function(mob)
        mob:hideName(true)
        mob:setUntargetable(true)
    end)

    chigoe:addListener('ENGAGE', 'CHIGOE_ENGAGE', function(mob, target)
        mob:hideName(false)
        mob:setUntargetable(false)
    end)

    chigoe:addListener('DISENGAGE', 'CHIGOE_DISENGAGE', function(mob, target)
        mob:hideName(true)
        mob:setUntargetable(true)
    end)

    chigoe:addListener('CRITICAL_TAKE', 'CHIGOE_CRITICAL_TAKE', function(mob)
         mob:setHP(0)
     end)

    chigoe:addListener('WEAPONSKILL_TAKE', 'CHIGOE_WEAPONSKILL_TAKE', function(target, wsid)
        if wsid then
            target:setHP(0)
        end
    end)

    chigoe:addListener('ABILITY_TAKE', 'CHIGOE_ABILITY_TAKE', function(mob, user, ability)
        local abilities =
        {
            46,  -- Shield Bash
            66,  -- Jump
            67,  -- High Jump
            77,  -- Weapon Bash
            82,  -- Chi Blast
            150, -- Tomahawk
            170, -- Angon
            201, -- Quickstep
            202, -- Boxstep
            203, -- Stutter Step
            312, -- Feather Step
        }

        for _, killAbility in ipairs(abilities) do
            if ability:getID() == killAbility then
                mob:setHP(0)
            end
        end
    end)
    
end

return g_mixins.families.chigoe
