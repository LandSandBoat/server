-----------------------------------
-- func: givemagianitem <player> <trialId> (RewardItem = False)
-- desc: Gives the Magian Item associated with the given Trial ID
-----------------------------------
---@type TCommand
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 'sib'
}

commandObj.onTrigger = function(player, targetName, trialId, isRewardItem)
    -- Early return: No target name.
    if not targetName then
        player:printToPlayer('You must enter a valid player name.')
        return
    end

    -- Early return: No trial ID input.
    if not trialId then
        player:printToPlayer('You must enter a valid Trial ID.')
        return
    end

    -- Early return: No valid target entity.
    local targetEntity = GetPlayerByName(targetName)
    if not targetEntity then
        player:printToPlayer(string.format('Player named \'%s\' not found!', targetName))
        return
    end

    -- Early return: No trial data.
    local trialData = xi.magian.trials[trialId]
    if not trialData then
        player:printToPlayer(string.format('Trial ID \'%u\' was not found.', trialId))
        return
    end

    local giveRewardItem = isRewardItem and true or false
    local itemData       = giveRewardItem and trialData.rewardItem or trialData.requiredItem
    if not itemData or not itemData.itemId then
        player:printToPlayer(string.format('Trial ID \'%u\' does not have a valid %s item.', trialId, giveRewardItem and 'reward' or 'required'))
        return
    end

    -- Check target inventory.
    if targetEntity:getFreeSlotsCount() == 0 then
        player:printToPlayer(string.format('Player \'%s\' does not have free space for that item!', targetName))
        return
    end

    -- Check if target already has the item.
    if targetEntity:hasItem(itemData.itemId) then
        player:printToPlayer(string.format('%s already has item %i.', targetEntity:getName(), itemData.itemId))
        return
    end

    -- Handle item.
    if giveRewardItem then
        xi.magian.giveRewardItem(targetEntity, trialId)
    else
        xi.magian.giveRequiredItem(targetEntity, trialId, true)
    end

    targetEntity:messageSpecial(zones[targetEntity:getZoneID()].text.ITEM_OBTAINED, itemData.itemId)
    player:printToPlayer(string.format('Gave player \'%s\' Item for Trial ID \'%u\' ', targetName, trialId))
end

return commandObj
