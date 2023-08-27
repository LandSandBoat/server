-- func: getfame
-- desc: Gets fame level of a target player
-----------------------------------

cmdprops =
{
    permission = 3,
    parameters = "si"
}

function error(player, msg)
    if msg == nil then
        msg = "!getfame [player] <fame_zone 0-15>"
    end

    player:PrintToPlayer(msg)
end

function onTrigger(player, target, famezone)
    -- validate target
    local targ

    if target == nil then
        error(player)

        return
    else
        targ = GetPlayerByName(target)
        if targ == nil then
            error(player, string.format("Player named '%s' not found or not a valid player!", target))

            return
        end
    end

    -- validate famezone
    local fameAreas =
    {
        "San d'Oria",               -- 0
        "Bastok",                   -- 1
        "Windurst",                 -- 2
        "Jeuno",                    -- 3
        "Selbina / Rabao",          -- 4
        "Norg",                     -- 5
        "Abyssea - Konschtat",      -- 6
        "Abyssea - Tahrongi",       -- 7
        "Abyssea - La Theine",      -- 8
        "Abyssea - Misareaux",      -- 9
        "Abyssea - Vunkerl",        -- 10
        "Abyssea - Attohwa",        -- 11
        "Abyssea - Altepa",         -- 12
        "Abyssea - Grauberg",       -- 13
        "Abyssea - Uleguerand",     -- 14
        "Adoulin"                   -- 15
    }

    -- Validate famezone
    if famezone == nil then
        -- error(player)
        -- return
        player:PrintToPlayer(string.format("Fame Report for player: %s", targ:getName()), xi.msg.channel.SYSTEM_3)
        for i = 0, 15 do
            player:PrintToPlayer(string.format("Area %s (%s): %s (Level: %s)", i, fameAreas[i + 1], player:getFame(i), player:getFameLevel(i)), xi.msg.channel.SYSTEM_3)
        end

        return
    elseif famezone < 0 or famezone > 15 then
        error(player, "Fame zone must be a value from 0 to 15, or omit for complete list.")

        return
    end

    local fameBaseValues = { 0, 50, 125, 225, 325, 425, 488, 550, 613 }
    local fame = player:getFame(famezone)
    local level = player:getFameLevel(famezone)

    if level < 9 then
        player:PrintToPlayer(string.format("%s's reputation in fame area %i (%s) is %i (Level %i). Next level at %i (%i points to go).", targ:getName(), famezone, fameAreas[famezone + 1], fame, level, fameBaseValues[level + 1], fameBaseValues[level + 1] - fame), xi.msg.channel.SYSTEM_3)
    else
        player:PrintToPlayer(string.format("%s's reputation in fame area %i (%s) is %i (Level %i).", targ:getName(), famezone, fameAreas[famezone + 1], fame, level), xi.msg.channel.SYSTEM_3)
    end
end
