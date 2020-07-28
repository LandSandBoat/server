-----------------------------------
--
-- Zone: GM Home (210)
--
-- Some cs event info:
-- 0 = Abyssea Debug
-- 1 = Mogsack Debug
-- ...
-- 139 = Janken challenges player to "Rock, Paper, Scissors"
-- ...
-- 140 = Camera test.
-- 141 = "Press confirm button to proceed" nonworking test.
--
-----------------------------------
local ID = require("scripts/zones/GM_Home/IDs")
-----------------------------------

function onInitialize(zone)
end

function onZoneIn( player, prevZone)
    local cs = -1

    return cs
end

function onEventUpdate( player, csid, option)
end

function onEventFinish( player, csid, option)
end
