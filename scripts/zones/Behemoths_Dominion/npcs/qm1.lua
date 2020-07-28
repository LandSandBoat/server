-----------------------------------
-- Area: Behemoth's Dominion
--  NPC: ???
-- Involved In Quest: The Talekeeper's Gift
-- !pos 211 4 -79 127
-----------------------------------
local ID = require("scripts/zones/Behemoths_Dominion/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if
        player:getCharVar("theTalekeeperGiftCS") == 3 and
        player:getCharVar("theTalekeepersGiftKilledNM") < 3 and
        not GetMobByID(ID.mob.TALEKEEPERS_GIFT_OFFSET + 0):isSpawned() and
        not GetMobByID(ID.mob.TALEKEEPERS_GIFT_OFFSET + 1):isSpawned() and
        not GetMobByID(ID.mob.TALEKEEPERS_GIFT_OFFSET + 2):isSpawned()
    then
        player:messageSpecial(ID.text.SENSE_OF_FOREBODING)
        SpawnMob(ID.mob.TALEKEEPERS_GIFT_OFFSET + 0):updateClaim(player) -- Picklix_Longindex
        SpawnMob(ID.mob.TALEKEEPERS_GIFT_OFFSET + 1):updateClaim(player) -- Moxnix_Nightgoggle
        SpawnMob(ID.mob.TALEKEEPERS_GIFT_OFFSET + 2):updateClaim(player) -- Doglix_Muttsnout
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
