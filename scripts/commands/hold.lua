-----------------------------------
-- func: !hold <target>
-----------------------------------
---@type TCommand
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 's'
}

commandObj.onTrigger = function(player, targetName)
    if targetName == nil then
        player:printToPlayer('You must enter a valid target name.')
        player:printToPlayer('!hold <player>')
        return
    end

    local target = GetPlayerByName(targetName)

    if target == nil then
        return
    end

    if target:hasStatusEffect(xi.effect.TERROR) then
        target:delStatusEffect(xi.effect.TERROR)
        target:printToPlayer('You can move again.')
        player:printToPlayer(string.format('%s has been released.', target:getName()))
    else
        target:addStatusEffect(xi.effect.TERROR, { power = 0, duration = 999999, origin = player, tick = 3 })
        target:injectActionPacket(target:getID(), 5, 282, 0, 0, 0, 10, 1)
        target:printToPlayer('You can\'t move.')
        player:printToPlayer(string.format('%s has been held.', target:getName()))
    end
end

return commandObj
