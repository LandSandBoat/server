-----------------------------------
-- func: givemagianitem <player> <trialId> (RewardItem = False)
-- desc: Gives the Magian Item associated with the given Trial ID
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 'sib'
}

commandObj.onTrigger = function(player, target, trialId, isRewardItem)
    local giveRewardItem = isRewardItem and true or false

    if
        target == nil or
        trialId == nil
    then
        player:PrintToPlayer('You must enter a valid player name and Trial ID.')
        return
    end

    local targ = GetPlayerByName(target)
    if targ == nil then
        player:PrintToPlayer(string.format('Player named \'%s\' not found!', target))
        return
    end

    -- Attempt to give the target the item
    if targ:getFreeSlotsCount() == 0 then
        player:PrintToPlayer(string.format('Player \'%s\' does not have free space for that item!', target))
    else
        if giveRewardItem then
            xi.magian.giveRewardItem(player, trialId)
        else
            xi.magian.giveRequiredItem(player, trialId)
        end

        player:PrintToPlayer(string.format('Gave player \'%s\' Item for Trial ID \'%u\' ', target, trialId))
    end
end

return commandObj
