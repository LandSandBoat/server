-----------------------------------
-- Area: West Sarutabaruta [S]
--  NPC: Sealed Entrance (Sealed_Entrance_2)
-- !pos 263.600 -6.512 40.000 95
-----------------------------------
local ID = require("scripts/zones/West_Sarutabaruta_[S]/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
-----------------------------------

function onTrigger(player, npc)
    local snakeOnThePlains = player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.SNAKE_ON_THE_PLAINS)
    local maskBit1 = player:getMaskBit(player:getCharVar("SEALED_DOORS"), 0)
    local maskBit2 = player:getMaskBit(player:getCharVar("SEALED_DOORS"), 1)
    local maskBit3 = player:getMaskBit(player:getCharVar("SEALED_DOORS"), 2)

    if snakeOnThePlains == QUEST_ACCEPTED and player:hasKeyItem(tpz.ki.ZONPAZIPPAS_ALLPURPOSE_PUTTY) then
        if not maskBit2 then
            if not maskBit1 or not maskBit3 then
                player:setMaskBit(player:getCharVar("SEALED_DOORS"), "SEALED_DOORS", 1, true)
                player:messageSpecial(ID.text.DOOR_OFFSET + 1, tpz.ki.ZONPAZIPPAS_ALLPURPOSE_PUTTY)
            else
                player:setMaskBit(player:getCharVar("SEALED_DOORS"), "SEALED_DOORS", 1, true)
                player:messageSpecial(ID.text.DOOR_OFFSET + 4, tpz.ki.ZONPAZIPPAS_ALLPURPOSE_PUTTY)
                player:delKeyItem(tpz.ki.ZONPAZIPPAS_ALLPURPOSE_PUTTY)
            end
        else
            player:messageSpecial(ID.text.DOOR_OFFSET + 2, tpz.ki.ZONPAZIPPAS_ALLPURPOSE_PUTTY)
        end
    elseif snakeOnThePlains == QUEST_COMPLETED then
        player:messageSpecial(ID.text.DOOR_OFFSET + 2, tpz.ki.ZONPAZIPPAS_ALLPURPOSE_PUTTY)
    else
        player:messageSpecial(ID.text.DOOR_OFFSET + 3)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
