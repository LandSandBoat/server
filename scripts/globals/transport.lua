-----------------------------------
-- Transport
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

xi = xi or {}
xi.transport = xi.transport or {}

xi.transport.message =
{
    NEARING = 0,
    DOCKING = 1
}

xi.transport.epochOffset =
{
    NEARING = 265,
    DOCKING = 290
}

xi.transport.messageTime =
{
    SILVER_SEA = 480
}

xi.transport.trigger =
{
    mhaura =
    {
        FERRY_ARRIVING_FROM_ALZAHBI = 0,
        FERRY_DEPARTING_TO_ALZAHBI  = 1,
        FERRY_ARRIVING_FROM_SELBINA = 2,
        FERRY_DEPARTING_TO_SELBINA  = 3
    }
}

xi.transport.interval =
{
    mhaura =
    {
        FROM_TO_ALZAHBI = 480,
        FROM_TO_SELBINA = 480
    }
}

xi.transport.offset =
{
    mhaura =
    {
        FERRY_ARRIVING_FROM_ALZAHBI = 159,
        FERRY_DEPARTING_TO_ALZAHBI  = 239,
        FERRY_ARRIVING_FROM_SELBINA = 399,
        FERRY_DEPARTING_TO_SELBINA  = 479
    }
}

xi.transport.pos =
{
    mhaura =
    {
        ARRIVING  = {7.06, -1.36, 2.20},
        DEPARTING = {8.26, -1.36, 2.20}
    }
}

-----------------------------------
-- public functions
-----------------------------------

xi.transport.captainMessage = function(npc, triggerID, messages)
    local playersInZone = npc:getZone():getPlayers()
    for _, player in pairs(playersInZone) do
        player:showText(player, messages[triggerID])
    end
end

xi.transport.dockMessage = function(npc, triggerID, messages, dock)
    npc:showText(npc, messages[triggerID])
    if (triggerID % 2) == 0 then
        npc:pathThrough(xi.transport.pos[dock].ARRIVING, PATHFLAG_WALLHACK)
    else
        npc:pathThrough(xi.transport.pos[dock].DEPARTING, PATHFLAG_WALLHACK)
    end
end
