-----------------------------------
-- Area: Quicksand Caves
--  NPC: ??? (qm5)
-- Involved in Quest: The Missing Piece
-- positions:
-- 1: !pos 770 0 -419
-- 2: !pos 657 0 -537
-- 3: !pos 749 0 -573
-- 4: !pos 451 -16 -739
-- 5: !pos 787 -16 -819
-- spawn in npc_list is 770 0 -419
-----------------------------------
local ID = require("scripts/zones/Quicksand_Caves/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
-----------------------------------

function onTrigger(player, npc)
    local TheMissingPiece = player:getQuestStatus(OUTLANDS, tpz.quest.id.outlands.THE_MISSING_PIECE)
    local HasAncientFragment = player:hasKeyItem(tpz.ki.ANCIENT_TABLET_FRAGMENT)
    local HasAncientTablet = player:hasKeyItem(tpz.ki.TABLET_OF_ANCIENT_MAGIC)

    -- Need to make sure the quest is flagged the player is no further along in the quest

    if (TheMissingPiece == QUEST_ACCEPTED and not(HasAncientTablet or HasAncientFragment or player:getTitle() == tpz.title.ACQUIRER_OF_ANCIENT_ARCANUM)) then
        player:addKeyItem(tpz.ki.ANCIENT_TABLET_FRAGMENT)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.ANCIENT_TABLET_FRAGMENT)

        -- move the ??? to a random location
        local i = math.random(0, 100)
        if (i >= 0 and i < 20) then
            npc:setPos(770, 0, -419, 0)
        elseif (i >= 20 and i < 40) then
            npc:setPos(657, 0, -537, 0)
        elseif (i >= 40 and i < 60) then
            npc:setPos(749, 0, -573, 0)
        elseif (i >= 60 and i < 80) then
            npc:setPos(451, -16, -739, 0)
        elseif (i >= 80 and i <= 100) then
            npc:setPos(787, -16, -819, 0)
        else
            npc:setPos(787, -16, -819, 0)
        end
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

function onEventUpdate(player, csid, option)
    -- print("CSID:", csid)
    -- print("RESULT:", option)
end

function onEventFinish(player, csid, option)
    -- print("CSID:", csid)
    -- print("RESULT:", option)
end
