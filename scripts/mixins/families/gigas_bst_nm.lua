-----------------------------------
-- Mixin for Gigas Beastmaster Notorious Monsters
-- (The kind that either use Familiar or Charm)
-- Currently used by: Enkelados, Eurymedon, Ophion, Pallas - Should also be added to Gigas Beastmaster when Expeditionary Force is implemented.
-----------------------------------
require('scripts/globals/mixins')
-----------------------------------

local variables =
{
    HPP_TRIGGER           = 'hppTrigger',      -- HP % threshold at which Familiar/Charm may activate
    COOLDOWN              = 'cooldown',        -- Duration in seconds between uses (default 7200)
    ENGAGE_DELAY          = 'engageDelay',     -- Delay after engage before ability can activate (default 2s)
    ENGAGE_READY_TIME     = 'engageReadyTime', -- Timestamp when engage delay expires
    NEXT_READY_TIME       = 'nextReadyTime',   -- Timestamp when cooldown expires
}

local configuration =
{
    minimumHppTrigger   = 40,   -- Minimum use threshold
    maximumHppTrigger   = 60,   -- Maximum use threshold
    cooldownSeconds     = 7200, -- 2 hour delay between uses
    engageDelaySeconds  = 2,    -- Delay after engage
}

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

g_mixins.families.gigas_beastmaster_nm = function(mob)
    mob:addListener('PRESPAWN', 'GIGAS_BEASTMASTER_PRESPAWN', function(mobArg)
        mobArg:setLocalVar(variables.HPP_TRIGGER,       math.random(configuration.minimumHppTrigger, configuration.maximumHppTrigger))
        mobArg:setLocalVar(variables.COOLDOWN,          configuration.cooldownSeconds)
        mobArg:setLocalVar(variables.ENGAGE_DELAY,      configuration.engageDelaySeconds)
        mobArg:setLocalVar(variables.ENGAGE_READY_TIME, 0)
        mobArg:setLocalVar(variables.NEXT_READY_TIME,   0)
    end)

    mob:addListener('ENGAGE', 'GIGAS_BEASTMASTER_ENGAGE', function(mobArg)
        local delay = mobArg:getLocalVar(variables.ENGAGE_DELAY)

        mobArg:setLocalVar(variables.ENGAGE_READY_TIME, GetSystemTime() + delay)
        mobArg:setLocalVar(variables.NEXT_READY_TIME,   0)
    end)

    mob:addListener('COMBAT_TICK', 'GIGAS_BEASTMASTER_COMBAT_TICK', function(mobArg)
        local currentTime = GetSystemTime()

        if currentTime < mobArg:getLocalVar(variables.ENGAGE_READY_TIME) then
            return
        end

        if currentTime < mobArg:getLocalVar(variables.NEXT_READY_TIME) then
            return
        end

        if mobArg:getHPP() > mobArg:getLocalVar(variables.HPP_TRIGGER) then
            return
        end

        -- Determine whether to use Familiar or Charm based on pet status (if alive, use Familiar, if dead, Charm)
        local abilityToUse = xi.mobSkill.CHARM

        local pet = mobArg:getPet()
        if pet and pet:isAlive() then
            abilityToUse = xi.jsa.FAMILIAR
        end

        mobArg:useMobAbility(abilityToUse)

        -- Apply cooldown to the 2-hour timer
        mobArg:setLocalVar(variables.NEXT_READY_TIME, currentTime + mobArg:getLocalVar(variables.COOLDOWN))
    end)
end

return g_mixins.families.gigas_beastmaster_nm
