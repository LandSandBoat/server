-----------------------------------
-- func: togglegm
-- desc: Toggles a GMs nameflags/icon.
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = ''
}

commandObj.onTrigger = function(player)
    -- GM Flag Definitions
    local gmFlags =
    {
        GM          = 0x04000000,
        GM_SENIOR   = 0x05000000,
        GM_LEAD     = 0x06000000,
        GM_PRODUCER = 0x07000000,
        SENIOR      = 0x01000000, -- Do NOT set these flags. These are here to
        LEAD        = 0x02000000, -- ensure all GM status is removed.
    }

    -- Configurable Options
    local minLevels =
    {
        GM          = 1, -- For 'whitelisting' players to have some commands, but not GM tier commands.
        GM_SENIOR   = 2, -- These are configurable so that commands may be restricted
        GM_LEAD     = 3, -- between different levels of GM's with the same icon.
        GM_PRODUCER = 4,
    }

    if player:checkNameFlags(gmFlags.GM) then
        if player:checkNameFlags(gmFlags.GM) then
            player:setFlag(gmFlags.GM)
        end

        if player:checkNameFlags(gmFlags.SENIOR) then
            player:setFlag(gmFlags.SENIOR)
        end

        if player:checkNameFlags(gmFlags.LEAD) then
            player:setFlag(gmFlags.LEAD)
        end
    else
        local gmlvl = player:getGMLevel()

        if gmlvl >= minLevels.GM_PRODUCER then
            player:setFlag(gmFlags.GM_PRODUCER)
        elseif gmlvl >= minLevels.GM_LEAD then
            player:setFlag(gmFlags.GM_LEAD)
        elseif gmlvl >= minLevels.GM_SENIOR then
            player:setFlag(gmFlags.GM_LEAD)
        elseif gmlvl >= minLevels.GM then
            player:setFlag(gmFlags.GM)
        end
    end
end

return commandObj
