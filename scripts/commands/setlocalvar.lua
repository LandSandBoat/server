-----------------------------------
-- func: setlocalvar <varName> <player/mob/npc> <ID>
-- desc: set player npc or mob local variable and value.
-----------------------------------

cmdprops =
{
    permission = 3,
    parameters = "siss"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!setlocalvar <variable name> <value> { 'player', 'mob', or 'npc' } { name or ID }")
end

function onTrigger(player, arg1, arg2, arg3, arg4)
    local zone = player:getZone()
    local varName = arg1
    local varValue = arg2

    if varName == nil then
        error(player, "You must provide a variable name.")
        return
    end

    if varValue == nil then
        error(player, "No varaiable value given for target.")
        return
    end

    local targ
    if arg3 == nil then
        targ = player:getCursorTarget()
    elseif arg4 ~= nil then
        local entityType = string.upper(arg3)
        if (entityType == 'NPC') or (entityType == 'MOB') then
            arg4 = tonumber(arg4)
            if zone:getType() == xi.zoneType.INSTANCED then
                local instance = player:getInstance()
                targ = instance:getEntity(bit.band(arg4, 0xFFF), xi.objType[entityType])
            elseif entityType == 'NPC' then
                targ = GetNPCByID(arg4)
            else
                targ = GetMobByID(arg4)
            end
        elseif entityType == 'PLAYER' then
            targ = GetPlayerByName(arg4)
        else
            error(player, "Invalid entity type.")
            return
        end
    else
        error(player, "Need to specify a target.")
        return
    end

    if targ == nil then
        error(player, "Invalid target.")
        return
    end

    targ:setLocalVar(varName, varValue)
    player:PrintToPlayer(string.format("%s's variable '%s' : %i", targ:getName(), varName, varValue))
end
