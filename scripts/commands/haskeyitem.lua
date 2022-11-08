-----------------------------------
-- func: haskeyitem <ID> <player>
-- desc: Checks if player has specified KeyItem.
--       Can use either of number or the variable string from keyitems.lua
-----------------------------------

require("scripts/globals/keyitems")

cmdprops =
{
    permission = 1,
    parameters = "ss"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!haskeyitem <key item ID> (player)")
end

function onTrigger(player, keyId, target)
    -- validate itemId
    if keyId == nil then
        error(player, "You must provide a key item ID.")
        return
    else
        keyId = tonumber(keyId) or xi.ki[string.upper(keyId)]
        if keyId == nil or keyId < 1 then
            error(player, "Invalid key item ID.")
            return
        end
    end

    -- validate target
    local targ
    if target == nil then
        targ = player:getCursorTarget()
        if targ == nil or not targ:isPC() then
            targ = player
        end
    else
        targ = GetPlayerByName(target)
        if targ == nil then
            error(player, string.format("Player named '%s' not found!", target))
            return
        end
    end

    -- report hasKeyItem
    if targ:hasKeyItem(keyId) then
        player:PrintToPlayer(string.format("%s has key item %i.", targ:getName(), keyId))
    else
        player:PrintToPlayer(string.format("%s does not have key item %i.", targ:getName(), keyId))
    end
end
