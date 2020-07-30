-----------------------------------
-- Area: Appolyon
-- NPC:  Sentinel_Column
-- !pos 643 0 -609 38
-----------------------------------
require("scripts/globals/limbus")

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player, npc, trade)
end

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player, npc)
    player:startEvent(221, 127)
end

-----------------------------------
-- onEventUpdate
-----------------------------------

function onEventUpdate(player, csid, option)
    player:updateEvent(
        0,
        player:getBattlefieldTimeLeft(1), -- SW Apollyon
        player:getBattlefieldTimeLeft(2), -- NW Apollyon
        player:getBattlefieldTimeLeft(3), -- SE Apollyon
        player:getBattlefieldTimeLeft(4), -- NE Apollyon
        player:getBattlefieldTimeLeft(5), -- Central Apollyon
        player:getBattlefieldTimeLeft(6)  -- CS Apollyon
    )
end

-----------------------------------
-- onEventFinish
-----------------------------------

function onEventFinish(player, csid, option)
end
