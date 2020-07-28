----------------------------------
-- Area: Fort Karugo Narugo [S]
--  NPC: Indescript Markings
-- Type: Quest
-- !pos -63 -75 4 96
-----------------------------------
local ID = require("scripts/zones/Fort_Karugo-Narugo_[S]/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    local loafersQuestProgress = player:getCharVar("AF_SCH_BOOTS")

    player:delStatusEffect(tpz.effect.SNEAK)

    -- SCH AF Quest - Boots
    if (loafersQuestProgress > 0 and loafersQuestProgress < 3 and player:hasKeyItem(tpz.ki.RAFFLESIA_DREAMSPIT) == false) then

        player:addKeyItem(tpz.ki.RAFFLESIA_DREAMSPIT)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.RAFFLESIA_DREAMSPIT)
        player:setCharVar("AF_SCH_BOOTS", loafersQuestProgress + 1)

        -- Move the markings around
        local positions = {
            [1] = {-72.612, -28.5, 671.24}, -- G-5 NE
            [2] = {-158,    -61,   268},    -- G-7
            [3] = {-2,      -52,   235},    -- H-8
            [4] = {224,     -28,   -22},    -- I-10
            [5] = {210,     -42,   -78},    -- I-9
            [6] = {-176,    -37,   617},    -- G-5 SW
            [7] = {29,      -13,   710}     -- H-5
        }

        local newPosition = npcUtil.pickNewPosition(npc:getID(), positions)

        npc:setPos(newPosition.x, newPosition.y, newPosition.z)
        -- player:PrintToPlayer("Markings moved to position index " .. newPosition)
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
