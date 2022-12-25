-----------------------------------
-- func: getfishers
-- desc: Returns a list of all players who have recently fished.
-----------------------------------

cmdprops =
{
    permission = 1,
    parameters = ""
}

function onTrigger(player)
    local fishers = GetRecentFishers()

    if #fishers == 0 then
        player:PrintToPlayer("No active fishers")
        return
    end

    for _, fisher in pairs(fishers) do
        player:PrintToPlayer(string.format("Name: %s Skill: %d", fisher.name, fisher.skill), xi.msg.channel.SYSTEM_3)
    end
end
