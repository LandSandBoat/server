-- func: sefish
-- desc: Sets or unsets whether a player has caught a particular fish
-----------------------------------
require("scripts/globals/fish")

cmdprops =
{
    permission = 1,
    parameters = "sss"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!setfish <fishid | fishname> <caught?> <player>")
end

function onTrigger(player, fish, flag, target)
    -- Check target
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

    -- Confirm the fish
    if fish == nil then
        error(player, "No fish identifier provided.")
        return
    end

    local id = tonumber(fish)
    local fishName

    if id ~= nil then
        -- Do a numerical lookup
        if not xi.fish.isFish(id) then
            -- Provided ID is not a fish
            error(player, "Provided ID is not a fish.")
            return
        end
    else
        -- fish is a string
        id = xi.fish.findFishId(fish)
        fishName = fish

        if id == 0 then
            -- given name is not a fish
            error(player, "Fish name not found")
            return
        end
    end

    -- Default to "set fish as caught"
    local statusString
    if flag == "true" or flag == "1" then
        statusString = "Caught"
        flag = true
    else
        statusString = "NOT Caught"
        flag = false
    end

    -- set the fish data
    targ:setFishCaught(id, flag)
    player:PrintToPlayer(string.format("Player: %s -> Fish ID %s (%s) status: %s", target, id, fishName, statusString))
end
