-----------------------------------
-- Monstrosity - Relinquish and leaving Monstrosity
-----------------------------------
xi = xi or {}
xi.monstrosity = xi.monstrosity or {}

-- Retail counts down from 4, 3 s apart. The JP wiki says 5, but every capture shows 4.
local countdownFrom = 4

-- JP wiki: any slip damage stops Relinquish before it counts, though the recast is still spent.
local relinquishBlockers =
{
    xi.effect.POISON,
    xi.effect.BIO,
    xi.effect.DIA,
    xi.effect.BURN,
    xi.effect.FROST,
    xi.effect.CHOKE,
    xi.effect.RASP,
    xi.effect.SHOCK,
    xi.effect.DROWN,
    xi.effect.REQUIEM,
    xi.effect.HELIX,
    xi.effect.KAUSTRA,
}

-- Bound by C++ (DO NOT CHANGE SIGNATURE). Relinquish, the death menu's Cancel and the Passage all leave
-- through here, back to the exact spot and jobs the player entered with.
xi.monstrosity.onMonstrosityReturnToEntrance = function(player)
    local data = player:getMonstrosityData()

    -- Retail announces each effect wearing off.
    for _, effect in pairs(player:getStatusEffects()) do
        player:delStatusEffect(effect:getEffectType())
    end

    -- A Monipulator made by GM command never recorded an entry, so it leaves through its home point.
    if data.entry_zone_id == 0 then
        player:changeJob(data.entry_mjob ~= 0 and data.entry_mjob or xi.job.WAR)
        player:changesJob(data.entry_sjob)
        player:warp()
        return
    end

    player:changeJob(data.entry_mjob)
    player:changesJob(data.entry_sjob)
    player:setPos(data.entry_x, data.entry_y, data.entry_z, data.entry_rot, data.entry_zone_id)
end

-- JP wiki: any hostile action stops Relinquish, a Gladiator's included. The argument holding the actor differs per event.
local relinquishInterrupts =
{
    { event = 'ATTACKED',         name = 'RELINQUISH_ATTACKED', actorArg = 2 },
    { event = 'MAGIC_TAKE',       name = 'RELINQUISH_MAGIC',    actorArg = 2 },
    { event = 'WEAPONSKILL_TAKE', name = 'RELINQUISH_SKILL',    actorArg = 1 },
}

local function stopRelinquish(player)
    player:setLocalVar('RELINQUISH_INTERRUPTED', 1)
    for _, listener in ipairs(relinquishInterrupts) do
        player:removeListener(listener.name)
    end
end

xi.monstrosity.relinquishOnAbility = function(player)
    for _, effect in ipairs(relinquishBlockers) do
        if player:hasStatusEffect(effect) then
            return
        end
    end

    player:setLocalVar('RELINQUISH_INTERRUPTED', 0)
    for _, listener in ipairs(relinquishInterrupts) do
        player:addListener(listener.event, listener.name, function(first, second)
            local actor  = listener.actorArg == 1 and first or second
            local target = listener.actorArg == 1 and second or first
            -- A gladiator shares the Monipulator's allegiance, but an adventurer can only act against a Monipulator.
            if
                actor:isMob() or
                actor:getAllegiance() ~= target:getAllegiance() or
                (actor:isPC() and actor:getMainJob() ~= xi.job.MON)
            then
                target:setLocalVar('RELINQUISH_INTERRUPTED', 1)
            end
        end)
    end

    player:messageBasic(xi.msg.basic.FERETORY_COUNTDOWN, 0, countdownFrom)

    -- Moving or a hostile action stops the countdown without a message.
    local start = player:getPos()
    for step = 1, countdownFrom do
        player:timer(step * 3000, function(playerArg)
            if playerArg:getLocalVar('RELINQUISH_INTERRUPTED') == 1 then
                return
            end

            local pos = playerArg:getPos()
            if
                playerArg:isDead() or
                pos.x ~= start.x or
                pos.z ~= start.z
            then
                stopRelinquish(playerArg)
                return
            end

            if step < countdownFrom then
                playerArg:messageBasic(xi.msg.basic.FERETORY_COUNTDOWN, 0, countdownFrom - step)
                return
            end

            stopRelinquish(playerArg)
            xi.monstrosity.onMonstrosityReturnToEntrance(playerArg)
        end)
    end
end
