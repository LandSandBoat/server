-----------------------------------
-- Set if you want new players to get a linkshell
-----------------------------------
require('modules/module_utils')
require('scripts/globals/player')
-----------------------------------
local m = Module:new('new_player_linkshell')

m:addOverride('xi.player.charCreate', function(player)
    local lsName = 'InsertLsNameHere' -- Name of linkshell
    player:addLinkpearl(lsName, true)
    super(player)
end)

return m
