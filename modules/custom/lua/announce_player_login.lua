-----------------------------------
-- Announce when a player logs in
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('announce_player_login')

m:addOverride('xi.player.onGameIn', function(player, firstLogin, zoning)
    super(player, firstLogin, zoning)

    if not zoning then
        -- PChar->loc.zone might not be populated by now, so we'll add a delay before we send this
        -- message.
        player:timer(2500, function(playerArg)
            local decoratedMessage = string.format('Player %s has logged in.', playerArg:getName())
            -- Sends announcement via ZMQ to all processes and zones
            playerArg:printToArea(decoratedMessage, xi.msg.channel.SYSTEM_3, xi.msg.area.SYSTEM, '', true)
        end)
    end
end)

return m
