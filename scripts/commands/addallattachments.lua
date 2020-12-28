---------------------------------------------------------------------------------------------------
-- func: addallattachments
-- desc: Unlocks all attachments
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 1,
    parameters = "s"
}

local ValidAttachments = {
  8193, 8194, 8195, 8196, 8197, 8198, 8224, 8225, 8226, 8227,
  8449, 8450, 8451, 8452, 8453, 8454, 8455, 8456, 8457, 8458,
  8481, 8482, 8483, 8484, 8485, 8486, 8487, 8488, 8489, 8490,
  8513, 8514, 8515, 8516, 8517, 8518, 8519, 8520, 8521, 8522,
  8523, 8545, 8546, 8547, 8548, 8549, 8550, 8551, 8552, 8553,
  8554, 8577, 8578, 8579, 8580, 8581, 8582, 8583, 8584, 8585,
  8586, 8609, 8610, 8611, 8612, 8613, 8614, 8615, 8616, 8617,
  8618, 8641, 8642, 8643, 8644, 8645, 8646, 8648, 8649, 8650,
  8673, 8674, 8675, 8676, 8677, 8678, 8680, 8681
}

local function AddAllAttachments(player)
    for i = 1, #ValidAttachments do
        player:unlockAttachment(ValidAttachments[i])
    end
end

function onTrigger(player, target)
    if (target == nil) then
        AddAllAttachments(player)
    else
        local targ = tpz.core.getPlayerByName(target)
        if (targ == nil) then
            player:PrintToPlayer(string.format( "Player named '%s' not found!", target ))
        else
            AddAllAttachments(targ)
        end
    end
end
