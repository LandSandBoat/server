-----------------------------------
-- func: getFishHistory
-- desc: Prints the history stats of a given player
-----------------------------------

cmdprops =
{
    permission = 1,
    parameters = "s"
}

function onTrigger(player, target)
    -- validate target
    local targ
    if target ~= nil then
        targ = GetPlayerByName(target)
    else
        targ = player:getCursorTarget()
    end

    if targ == nil then
        if target ~= nil then
            player:PrintToPlayer(string.format("Player named '%s' not found!", target))
            return
        else
            player:PrintToPlayer("Find a target, either by name or cursor!")
            return
        end
    elseif not targ:isPC() then
        player:PrintToPlayer("Target is not a player!")
        return
    end

    local fishStats = targ:getFishingStats()
    player:PrintToPlayer(string.format("Showing Fishing Stats for: %s", targ:getName()), xi.msg.channel.SYSTEM_3)
    player:PrintToPlayer(string.format("Lines Cast: %s", fishStats["fishLinesCast"]), xi.msg.channel.SYSTEM_3)
    player:PrintToPlayer(string.format("Fish Caught: %s", fishStats["fishReeled"]), xi.msg.channel.SYSTEM_3)
    player:PrintToPlayer(string.format("Biggest Fish: %s ilms (%s)", fishStats["fishLongestLength"], xi.fish.getFishName(fishStats['fishLongestId'])), xi.msg.channel.SYSTEM_3)
    player:PrintToPlayer(string.format("Heaviest Fish: %s ponzes (%s)", fishStats["fishHeaviestWeight"], xi.fish.getFishName(fishStats['fishHeaviestId'])), xi.msg.channel.SYSTEM_3)
end
