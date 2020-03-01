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

tpz.transport.dockPorterMhauraTrigger =
{
    FERRY_ARRIVING_FROM_ALZAHBI  = 0,
    FERRY_DEPARTING_TO_ALZAHBI = 1,
    FERRY_ARRIVING_FROM_SELBINA  = 2,
    FERRY_DEPARTING_TO_SELBINA = 3
}

tpz.transport.dockPorterMhauraOffset =
{
    FERRY_ARRIVING_FROM_ALZAHBI = 159,
    FERRY_DEPARTING_TO_ALZAHBI = 239,
    FERRY_ARRIVING_FROM_SELBINA = 399,
    FERRY_DEPARTING_TO_SELBINA = 479
}

tpz.transport.dockPorterMhauraInterval =
{
    FROM_TO_ALZAHBI = 480,
    FROM_TO_SELBINA = 480
}

tpz.transport.dockPorterMhauraPos =
{
    ARRIVING = {7.06, -1.36, 2.49},
    DEPARTING = {8.26, -1.36, 2.20}
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

tpz.transport.dockPorterMhauraMessages = function(npc, triggerID, messages)
    npc:showText(npc, messages[triggerID])
    if triggerID == tpz.transport.dockPorterMhauraTrigger.FERRY_ARRIVING_FROM_ALZAHBI or
        triggerID == tpz.transport.dockPorterMhauraTrigger.FERRY_ARRIVING_FROM_SELBINA then
        npc:pathThrough(tpz.transport.dockPorterMhauraPos.ARRIVING, PATHFLAG_WALLHACK)
    elseif triggerID == tpz.transport.dockPorterMhauraTrigger.FERRY_DEPARTING_TO_ALZAHBI or
        triggerID == tpz.transport.dockPorterMhauraTrigger.FERRY_DEPARTING_TO_SELBINA then
        npc:pathThrough(tpz.transport.dockPorterMhauraPos.DEPARTING, PATHFLAG_WALLHACK)
    end
end