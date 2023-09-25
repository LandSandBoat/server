---------------------------------------------------------------------------------------------------
-- func: geteffects
-- desc: prints list of all effects
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 3,
    parameters = ""
}

local function getEffectName(value)
    for k, v in pairs(xi.effect) do
        if v == value then
            return k
        end
    end

    return nil
end

function onTrigger(player)
    local target = player:getCursorTarget()
    if target == nil then
        player:PrintToPlayer("Target something first.")
        return
    end

    local targetType = target:getObjType()

    if targetType == xi.objType.NPC then
        player:PrintToPlayer("Target something other than an NPC..They don't have effects!")
        return
    end

    local targetStatusEffects = target:getStatusEffects()

    if next(targetStatusEffects) ~= nil then
        player:PrintToPlayer(string.format("Showing Active Effects for: %s", target:getName()), xi.msg.channel.SYSTEM_3)
        player:PrintToPlayer("[Effect Id] [Name] [Power] [Sub Id] [SubPower]", xi.msg.channel.SYSTEM_3)
        for _, effect in pairs(targetStatusEffects) do
            player:PrintToPlayer(string.format("%-5s %s %s %s %s", effect:getType(), getEffectName(effect:getType()), effect:getPower(), effect:getSubType(), effect:getSubPower()), xi.msg.channel.SYSTEM_3)
        end
    else
        player:PrintToPlayer("No active effects found!")
    end
end
