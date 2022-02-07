-----------------------------------
-- func: pupblmhead
-- desc: Unlocks all attachments
-----------------------------------

cmdprops =
{
    permission = 1,
    parameters = "s"
}

local ValidAttachments = {
	8198,
}

local function AddAllAttachments(player)
    for i = 1, #ValidAttachments do
        player:unlockAttachment(ValidAttachments[i])
    end
    player:PrintToPlayer(string.format("%s now has pup blm head.", player:getName()))
end

function onTrigger(player, target)
    if (target == nil) then
        AddAllAttachments(player)
    else
        local targ = GetPlayerByName(target)
        if (targ == nil) then
            player:PrintToPlayer(string.format( "Player named '%s' not found!", target ))
        else
            AddAllAttachments(targ)
        end
    end
end