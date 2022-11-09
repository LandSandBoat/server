-----------------------------------
-- func: setplayernation
-- desc: Sets the target players nation.
-----------------------------------

cmdprops =
{
    permission = 1,
    parameters = "ss"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!setplayernation (player) <nation>")
    player:PrintToPlayer("Nations: 0=San d'Oria 1=Bastok 2=Windurst")
end

function onTrigger(player, arg1, arg2)
    local targ
    local nation

    -- validate target
    if arg2 ~= nil then
        targ = GetPlayerByName(arg1)

        if targ == nil then
            error(player, string.format("Player named '%s' not found!", arg1))
            return
        end

        nation = tonumber(arg2)
    elseif arg1 ~= nil then
        targ = player
        nation = tonumber(arg1)
    end

    -- validate nation
    if nation == nil or nation < 0 or nation > 2 then
        error(player, "Invalid nation ID.")
        return
    end

    local nationByNum =
    {
        [0] = "San d'Oria",
        [1] = "Bastok",
        [2] = "Windurst"
    }

    -- set nation
    targ:setNation(nation)
    player:PrintToPlayer(string.format("Set %s's home nation to %s.", targ:getName(), nationByNum[nation]))
    player:PrintToPlayer("NOTE! This does NOT clear or update ANY mission or related variables! ")
end
