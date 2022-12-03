-----------------------------------
-- func: checklocalvar <varName> { 'player'/'mob'/'npc' } { name/ID }
-- desc: checks player or npc local variable and returns result value.
-----------------------------------

cmdprops =
{
    permission = 1,
    parameters = "sss"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!checklocalvar <variable name> { 'player', 'mob', or 'npc' } { name or ID }")
end

function onTrigger(player, arg1, arg2, arg3)
    local zone = player:getZone()
    local varName = arg1
    local targ = arg3

    if varName == nil then
        error(player, "You must provide a variable name.")
        return
    end

    if arg2 == nil then
        targ = player:getCursorTarget()
    elseif arg3 ~= nil then
        local entityType = string.upper(arg2)
        if entityType == 'NPC' or entityType == 'MOB' then
            arg3 = tonumber(arg3)
            if zone:getType() == xi.zoneType.INSTANCED then
                local instance = player:getInstance()
                targ = instance:getEntity(bit.band(arg3, 0xFFF), xi.objType[entityType])
            elseif entityType == 'NPC' then
                targ = GetNPCByID(arg3)
            else
                targ = GetMobByID(arg3)
            end
        elseif entityType == 'PLAYER' then
            targ = GetPlayerByName(arg3)
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

    player:PrintToPlayer(string.format("%s's variable '%s' : %i", targ:getName(), varName, targ:getLocalVar(varName)))
end
