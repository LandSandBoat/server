-----------------------------------
-- Area: Davoi
--  NPC: Wall of Banishing
-- Used In Quest: Whence Blows the Wind
-- !pos 181 0.1 -218 149
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
local ID = require("scripts/zones/Davoi/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    if (npc:getAnimation() == 9) then
        if (player:hasKeyItem(tpz.ki.CRIMSON_ORB)) then
            player:startEvent(42)
        else
            player:messageSpecial(ID.text.CAVE_HAS_BEEN_SEALED_OFF)
            player:messageSpecial(ID.text.MAY_BE_SOME_WAY_TO_BREAK)
            player:setCharVar("miniQuestForORB_CS", 99)
        end
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option, npc)

    if (csid == 42 and option == 0) then
        player:messageSpecial(ID.text.POWER_OF_THE_ORB_ALLOW_PASS)
        npc:openDoor(16)
    end

end
