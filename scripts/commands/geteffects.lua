-----------------------------------
-- func: geteffects [target]
-- desc: Lists all active status effects on the specified target (or self if no target specified)
--
-- Usage:
-- !geteffects          - List effects on yourself
-- !geteffects <name>   - List effects on a player with the specified name
-- !geteffects <id>     - List effects on entity with the specified ID
-- !geteffects          - List effects on your cursor target (if targeting something)
-----------------------------------
---@type TCommand
local commandObj = {}

commandObj.cmdprops =
{
    permission = 0,
    parameters = 's'
}

local function formatDuration(duration)
    if duration <= 0 then
        return 'Permanent'
    end

    local seconds = math.floor(duration / 1000)
    local minutes = math.floor(seconds / 60)
    local hours = math.floor(minutes / 60)

    if hours > 0 then
        return string.format('%dh %dm %ds', hours, minutes % 60, seconds % 60)
    elseif minutes > 0 then
        return string.format('%dm %ds', minutes, seconds % 60)
    else
        return string.format('%ds', seconds)
    end
end

local function getEffectName(effect)
    for name, id in pairs(xi.effect) do
        if id == effect:getEffectType() then
            return name
        end
    end

    return 'Unknown Effect'
end

local function listEffects(target, player)
    if not target then
        player:printToPlayer('No valid target found.')
        return
    end

    local effects = target:getStatusEffects()
    if not effects or next(effects) == nil then
        player:printToPlayer(string.format('%s has no active effects.', target:getName()), xi.msg.channel.SYSTEM_3)
        return
    end

    local effectCount = 0

    for _, effect in pairs(effects) do
        if effect and not effect.deleted then
            effectCount = effectCount + 1
            local effectName = getEffectName(effect)
            local power = effect:getPower()
            local subPower = effect:getSubPower()
            local timeRemaining = effect:getTimeRemaining()
            local tick = effect:getTick()
            local flags = effect:getEffectFlags()

            local effectId = effect:getEffectType()
            local effectLine = string.format('[%d] %s (%d)', effectCount, effectName, effectId)

            local details = {}
            if power > 0 then
                table.insert(details, string.format('Power: %d', power))
            end

            if subPower > 0 and subPower ~= power then
                table.insert(details, string.format('SubPower: %d', subPower))
            end

            if timeRemaining > 0 then
                table.insert(details, string.format('Time: %s', formatDuration(timeRemaining)))
            end

            if tick > 0 then
                table.insert(details, string.format('Tick: %ds', math.floor(tick / 1000)))
            end

            local flagList = {}
            if bit.band(flags, xi.effectFlag.SONG) ~= 0 then
                table.insert(flagList, 'Song')
            end

            if bit.band(flags, xi.effectFlag.ROLL) ~= 0 then
                table.insert(flagList, 'Roll')
            end

            if bit.band(flags, xi.effectFlag.FOOD) ~= 0 then
                table.insert(flagList, 'Food')
            end

            if bit.band(flags, xi.effectFlag.DISPELABLE) ~= 0 then
                table.insert(flagList, 'Dispelable')
            end

            if #flagList > 0 then
                table.insert(details, string.format('[%s]', table.concat(flagList, ',')))
            end

            if #details > 0 then
                effectLine = effectLine .. ' - ' .. table.concat(details, ' | ')
            end

            player:printToPlayer(effectLine, xi.msg.channel.SYSTEM_3)
        end
    end
end

commandObj.onTrigger = function(player, target)
    local targetEntity = nil
    local cursorTarget = player:getCursorTarget()

    if target then
        -- Try to find target by name or ID
        local targetId = tonumber(target)
        if targetId then
            -- Target is an ID - try mob first, then player
            targetEntity = GetMobByID(targetId)
            if not targetEntity then
                targetEntity = GetPlayerByID(targetId)
            end

            if not targetEntity then
                player:printToPlayer(string.format('No entity found with ID %s.', target))
                return
            end
        else
            -- Target is a name - only players can be found by name
            targetEntity = GetPlayerByName(target)
            if not targetEntity then
                player:printToPlayer(string.format('Player %s not found. For mobs, target them and use !geteffects without parameters, or use their ID.', target))
                return
            end
        end
    elseif cursorTarget then
        -- No target specified but have cursor target
        targetEntity = cursorTarget
    else
        -- No target and no cursor target - use self
        targetEntity = player
    end

    -- Check if target is valid
    if not targetEntity or targetEntity:isDead() then
        player:printToPlayer('Invalid target or target is dead.')
        return
    end

    listEffects(targetEntity, player)
end

return commandObj
