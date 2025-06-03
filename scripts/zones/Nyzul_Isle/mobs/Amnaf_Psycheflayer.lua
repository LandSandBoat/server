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

--[[
entity.onSpikesDamage = function(mob, target, damage)
    -- Amnaf's Ice Spikes from blm spell will process first on retail.
    -- In battleutils.cpp the spike effect is checked before trying to process onSpikesDamage()
    -- thus no status effect = no proc, but 2 spike effects can't coexist..
    -- local resist = getEffectResistance(target, xi.effect.CURSE_I) -- NO, dont ever uncomment this.
    local rnd = math.random (1, 100)
    -- This res check is a little screwy till we get the server's resistance handling closer to retail.
    -- looks like applyResistanceAddEffect() doesn't even handle status resistance, only elemental.
    if resist > rnd or rnd <= 20 then
        return 0, 0, 0
    else
        -- Estimated from https://youtu.be/7jsXnwkqMM4?t=5m42s
        -- And yes it does overwrite itself
        target:addStatusEffect(xi.effect.CURSE_I, 10, 0, 10)
        return xi.subEffect.CURSE_SPIKES, xi.msg.basic.STATUS_SPIKES, xi.effect.CURSE_I
    end
end
]]

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
