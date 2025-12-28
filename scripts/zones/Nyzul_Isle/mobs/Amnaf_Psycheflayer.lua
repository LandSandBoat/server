-----------------------------------
-- Area: Nyzul Isle (Path of Darkness)
--  Mob: Amnaf Psycheflayer
-----------------------------------
local ID = zones[xi.zone.NYZUL_ISLE]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    -- mob:setMobMod(xi.mobMod.AUTO_SPIKES, 1)
end

entity.onMobSpawn = function(mob)
    mob:addListener('WEAPONSKILL_STATE_ENTER', 'WS_START_MSG', function(mobArg, skillID)
        mobArg:showText(mobArg, ID.text.WHEEZE)
    end)
end

entity.onMobEngage = function(mob, target)
    local naja = GetMobByID(ID.mob.NAJA_SALAHEEM, mob:getInstance())

    if naja then
        naja:setLocalVar('ready', 1)
    end

    mob:showText(mob, ID.text.CANNOT_LET_YOU_PASS)
end

entity.onSpellPrecast = function(mob, spell)
    mob:showText(mob, ID.text.PHSHOOO)
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller then
        mob:showText(mob, ID.text.NOT_POSSIBLE)
    end
end

entity.onMobDespawn = function(mob)
    local instance = mob:getInstance()
    if not instance then
        return
    end

    instance:setProgress(instance:getProgress() + 2)
end

return entity
