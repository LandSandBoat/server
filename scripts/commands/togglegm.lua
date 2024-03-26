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
    local gmlvl          = player:getGMLevel()
    local visibleGmLevel = player:getVisibleGMLevel()

    if visibleGmLevel > 0 then
        player:setVisibleGMLevel(0)
    else
        -- See https://github.com/atom0s/XiPackets/tree/main/world/server/0x0037, flags0_t GmLevel
        player:setVisibleGMLevel(math.min(7, gmlvl + 3))
    end
end

return commandObj
