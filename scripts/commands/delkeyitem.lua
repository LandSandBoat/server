-----------------------------------
-- func: delkeyitem
-- desc: Deletes the given key item from the player.
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 'ss'
}

local function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer('!delkeyitem <key item ID> (player)')
end

commandObj.onTrigger = function(player, keyId, target)
    -- validate key item id
    if keyId == nil then
        error(player, 'You must supply a key item ID.')
        return
    end

    keyId = tonumber(keyId) or xi.ki[string.upper(keyId)]
    if keyId == nil or keyId < 1 then
        error(player, 'Invalid Key Item ID.')
        return
    end

    -- validate target
    local targ
    if target == nil then
        targ = player
    else
        targ = GetPlayerByName(target)
        if targ == nil then
            error(player, string.format('Player named "%s" not found!', target))
            return
        end
    end

    -- delete key item from target
    if targ:hasKeyItem(keyId) then
        local ID = zones[targ:getZoneID()]
        targ:delKeyItem(keyId)
        targ:messageSpecial(ID.text.KEYITEM_OBTAINED + 1, keyId)
        player:PrintToPlayer(string.format('Key item %i deleted from %s.', keyId, targ:getName()))
    else
        player:PrintToPlayer(string.format('%s does not have key item %i.', targ:getName(), keyId))
    end
end

return commandObj
