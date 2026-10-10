-----------------------------------
-- Monstrosity - Relinquish and leaving Monstrosity
-----------------------------------
require('scripts/globals/monstrosity/constants')
-----------------------------------
xi = xi or {}
xi.monstrosity = xi.monstrosity or {}

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

    if
        xi.monstrosity.returnToFeretory and
        player:getZoneID() ~= xi.zone.FERETORY
    then
        local entrance = xi.monstrosity.feretoryEntrance
        player:setPos(entrance.x, entrance.y, entrance.z, entrance.rot, xi.zone.FERETORY)
        return
    end

    player:changeJob(data.entry_mjob)
    player:changesJob(data.entry_sjob)
    player:setPos(data.entry_x, data.entry_y, data.entry_z, data.entry_rot, data.entry_zone_id)
end

-- Any action a monster takes on the player stops Relinquish. The argument holding the monster differs per event.
local relinquishInterrupts =
{
    { event = 'ATTACKED',         name = 'RELINQUISH_ATTACKED', actorArg = 2 },
    { event = 'MAGIC_TAKE',       name = 'RELINQUISH_MAGIC',    actorArg = 2 },
    { event = 'WEAPONSKILL_TAKE', name = 'RELINQUISH_SKILL',    actorArg = 1 },
}

-- Moving or a hostile action stops the countdown without a message.
local function relinquishCountdown(player, start)
    player:timer(xi.monstrosity.relinquishInterval, function(playerArg)
        local pos     = playerArg:getPos()
        local count   = playerArg:getLocalVar('RELINQUISH_COUNTDOWN') - 1
        local stopped =
            playerArg:getLocalVar('RELINQUISH_INTERRUPTED') == 1 or
            playerArg:isDead() or
            pos.x ~= start.x or
            pos.z ~= start.z

        if stopped or count == 0 then
            for _, listener in ipairs(relinquishInterrupts) do
                playerArg:removeListener(listener.name)
            end

            if not stopped then
                xi.monstrosity.onMonstrosityReturnToEntrance(playerArg)
            end

            return
        end

        playerArg:messageBasic(xi.msg.basic.FERETORY_COUNTDOWN, 0, count)
        playerArg:setLocalVar('RELINQUISH_COUNTDOWN', count)
        relinquishCountdown(playerArg, start)
    end)
end

xi.monstrosity.relinquishOnAbility = function(player)
    for _, effect in ipairs(xi.monstrosity.relinquishBlockers) do
        if player:hasStatusEffect(effect) then
            return
        end
    end

    local count = xi.monstrosity.relinquishCount
    player:setLocalVar('RELINQUISH_INTERRUPTED', 0)
    player:setLocalVar('RELINQUISH_COUNTDOWN', count)
    for _, listener in ipairs(relinquishInterrupts) do
        player:addListener(listener.event, listener.name, function(first, second)
            local actor  = listener.actorArg == 1 and first or second
            local target = listener.actorArg == 1 and second or first
            if actor:isMob() then
                target:setLocalVar('RELINQUISH_INTERRUPTED', 1)
            end
        end)
    end

    player:messageBasic(xi.msg.basic.FERETORY_COUNTDOWN, 0, count)
    relinquishCountdown(player, player:getPos())
end
