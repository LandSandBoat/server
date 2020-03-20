------------------------------------
-- Transport
------------------------------------
require("scripts/globals/zone")
------------------------------------

tpz = tpz or {}
tpz.transport = tpz.transport or {}

tpz.transport.message =
{
    NEARING = 0,
    DOCKING = 1
}

tpz.transport.epochOffset =
{
    NEARING = 265,
    DOCKING = 290
}

tpz.transport.messageTime =
{
    SILVER_SEA = 480
}

-------------------------------------------------
-- public functions
-------------------------------------------------

tpz.transport.captainMessage = function(npc, triggerID, messages)
    local playersInZone = npc:getZone():getPlayers()
    for _, player in pairs(playersInZone) do
        player:showText(player, messages[triggerID])
    end
end
