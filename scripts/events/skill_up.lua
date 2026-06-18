-----------------------------------
-- Skill Up campaign:
-- +33% Combat, Magic, and Craft skill up rate
-- Currently only obtainable at Mendi in Lower Jeuno
-----------------------------------

xi = xi or {}
xi.events = xi.events or {}
xi.events.skillUp = xi.events.skillUp or {}

local scheduledEvent = xi.events.ScheduledEvent

local event = scheduledEvent:new('skillUp')

xi.events.skillUp.getIsActive = function()
    if type(event.getIsActive) == 'function' then
        return event:getIsActive()
    end

    return false
end

xi.events.skillUp.onNpcTrigger = function(npc, player)
    if xi.events.skillUp.getIsActive() then
        local power = 0
        local tick = 0
        local duration = 3 * 60 * 60

        player:printToPlayer('Enjoy the enhanced learning! Go master your skills, adventurer!', xi.msg.channel.SAY, npc:getName())
        player:addStatusEffect(xi.effect.UNBRIDLED_LEARNING, { power = power, tick = tick, duration = duration, origin = player })

        return true
    end

    return false
end

xi.events.skillUp.mods =
{
    xi.mod.COMBAT_SKILLUP_RATE,
    xi.mod.MAGIC_SKILLUP_RATE,
    xi.mod.SYNTH_SKILL_GAIN,
}

xi.events.skillUp.onEffectGain = function(target, effect)
    for _, mod in pairs(xi.events.skillUp.mods) do
        target:addMod(mod, 33)
    end
end

xi.events.skillUp.onEffectLose = function(target, effect)
    for _, mod in pairs(xi.events.skillUp.mods) do
        if target:getMod(mod) ~= 0 then
            target:delMod(mod, target:getMod(mod))
        end
    end
end

return xi.events.skillUp
