-----------------------------------
-- Area: Nyzul Isle (Path of Darkness)
--  Mob: Amnaf Psycheflayer
-----------------------------------
local ID = require("scripts/zones/Nyzul_Isle/IDs")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------

function onMobInitialize(mob)
    -- mob:setMobMod(tpz.mobMod.AUTO_SPIKES, 1)
end

function onMobSpawn(mob)
    mob:addListener("WEAPONSKILL_STATE_ENTER", "WS_START_MSG", function(mob, skillID)
        mob:showText(mob, ID.text.WHEEZE)
    end)
end

function onMobEngaged(mob, target)
    local naja = mob:getInstance():getEntity(bit.band(ID.mob[58].NAJA, 0xFFF))
    naja:setLocalVar("ready", 1)
    mob:showText(mob, ID.text.CANNOT_LET_YOU_PASS)
end

--[[
function onSpikesDamage(mob, target, damage)
    -- Amnaf's Ice Spikes from blm spell will process first on retail.
    -- In battleutils.cpp the spike effect is checked before trying to process onSpikesDamage()
    -- thus no status effect = no proc, but 2 spike effects can't coexist..
    local resist = getEffectResistance(target, tpz.effect.CURSE_I)
    local rnd = math.random (1, 100)
    -- This res check is a little screwy till we get Topaz's resistance handling closer to retail.
    -- looks like applyResistanceAddEffect() doesn't even handle status resistance, only elemental.
    if (resist > rnd or rnd <= 20) then
        return 0, 0, 0
    else
        -- Estimated from https://youtu.be/7jsXnwkqMM4?t=5m42s
        -- And yes it does overwrite itself
        target:addStatusEffect(tpz.effect.CURSE_I, 10, 0, 10)
        return tpz.subEffect.CURSE_SPIKES, tpz.msg.basic.STATUS_SPIKES, tpz.effect.CURSE_I
    end
end
]]

function onSpellPrecast(mob, spell)
    mob:showText(mob, ID.text.PHSHOOO)
end

function onMobDeath(mob, player, isKiller)
    if (isKiller) then
        mob:showText(mob, ID.text.NOT_POSSIBLE)
    end
end

function onMobDespawn(mob)
    local instance = mob:getInstance()
    instance:setProgress(instance:getProgress() + 2)
end
