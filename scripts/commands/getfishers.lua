-----------------------------------
-- func: getfishers <MinutesToLookback>
-- desc: Returns a list of all players who have recently fished.
--       The default period to look back is 5 minutes but command
--       accepts parameter between 1 and 60 minutes
-----------------------------------
---@type TCommand
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 'i'
}

local function error(player, msg)
    player:printToPlayer(msg)
    player:printToPlayer('!getfishers <MinutesToLookback>')
end

commandObj.onTrigger = function(player, minutes)
    -- default look back period is 5 minutes
    if minutes == nil then
        minutes = 5
    elseif minutes < 1 or minutes > 60 then
        error(player, 'The specified look back period must be between 1 and 60 minutes.')
        return
    end

    local fishers = GetRecentFishers(minutes)

    if #fishers == 0 then
        player:printToPlayer(string.format('No active fishers in past %i minutes.', minutes), xi.msg.channel.SYSTEM_3)
        return
    end

    player:printToPlayer(string.format('Active fishers in past %i minutes:', minutes), xi.msg.channel.SYSTEM_3)
    for _, fisher in pairs(fishers) do
        player:printToPlayer(string.format('Name: %s, Zone: %s, JobLevel: %d, Skill: %d',
        fisher.playerName, fisher.zoneName, fisher.jobLevel, fisher.skill), xi.msg.channel.SYSTEM_3)
    end
end

return commandObj
