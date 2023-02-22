-----------------------------------
-- func: addpupblmhead
-- desc: Adds the Spiritreaver head attachment
-----------------------------------

cmdprops =
{
    permission = 2,
    parameters = "s"
}

local validAttachments =
{
    8198,
}

local function AddAllAttachments(player)
    local ID = zones[player:getZoneID()]
    for i = 1, #validAttachments do
        player:unlockAttachment(validAttachments[i])
    end

    player:messageSpecial(ID.text.ITEM_OBTAINED, validAttachments[1])
end

function onTrigger(player, target)
    if target == nil then
        AddAllAttachments(player)
    else
        local targ = GetPlayerByName(target)
        if targ == nil then
            player:PrintToPlayer(string.format("Player named '%s' not found!", target))
        else
            AddAllAttachments(targ)
            player:PrintToPlayer(string.format("You have given %s the pup blm head.", targ:getName()))
        end
    end
end
