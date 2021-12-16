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
local zone_object = {}

-- Name Vis:
-- 1 : I Icon
-- 8 : Hide name
-- 128 : Ghost effect

-- Flags:
-- 32 : Call for Help
-- 256 : Hide HP
-- 2046 : Untargettable
-- 65536 : Green/Yellow thing
-- 262,144 : GM Flag

-- Name Prefix:
-- 8   : Targettable by spells, client menu (Blue name)
-- 128 : NPC invisible

zone_object.onInitialize = function(zone)
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1

    return cs
end

zone_object.onEventUpdate = function(player, csid, option)
end

zone_object.onEventFinish = function(player, csid, option)
end

return zone_object
