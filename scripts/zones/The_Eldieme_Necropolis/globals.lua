-----------------------------------
-- Zone: The Eldieme Necropolis (195)
-- Desc: this file contains functions that are shared by multiple luas in this zone's directory
-----------------------------------
local ID = require("scripts/zones/The_Eldieme_Necropolis/IDs")
require("scripts/globals/items")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/settings")
require("scripts/globals/quests")
require("scripts/globals/status")
-----------------------------------

local THE_ELDIEME_NECROPOLIS =
{
    --[[..............................................................................................
        click on any of the three Ancient Papyrus shred QMs
        ..............................................................................................]]
    papyrusQmOnTrigger = function(player, ki)
        if not xi.settings.OLDSCHOOL_G1 then

            if
                player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.IN_DEFIANT_CHALLENGE) == QUEST_ACCEPTED and
                not player:hasItem(xi.items.PIECE_OF_ANCIENT_PAPYRUS) and not player:hasKeyItem(ki)
            then
                npcUtil.giveKeyItem(player, ki)
            end

            if
                player:hasKeyItem(xi.ki.ANCIENT_PAPYRUS_SHRED1) and
                player:hasKeyItem(xi.ki.ANCIENT_PAPYRUS_SHRED2) and
                player:hasKeyItem(xi.ki.ANCIENT_PAPYRUS_SHRED3)
            then
                npcUtil.giveItem(player, xi.items.PIECE_OF_ANCIENT_PAPYRUS)
            end

            if player:hasItem(xi.items.PIECE_OF_ANCIENT_PAPYRUS) then
                player:delKeyItem(xi.ki.ANCIENT_PAPYRUS_SHRED1)
                player:delKeyItem(xi.ki.ANCIENT_PAPYRUS_SHRED2)
                player:delKeyItem(xi.ki.ANCIENT_PAPYRUS_SHRED3)
            end
        end
    end,

    --[[..............................................................................................
        click on any of the intersection gates
        ..............................................................................................]]
    gateOnTrigger = function(player, npc)
        if npc:getAnimation() == xi.anim.CLOSE_DOOR then
            if player:hasKeyItem(xi.ki.MAGICKED_ASTROLABE) then
                npc:openDoor(8)
            else
                player:messageSpecial(ID.text.SOLID_STONE)
            end
        end
    end,

    --[[..............................................................................................
        click on any of the switch plates
        ..............................................................................................]]
    plateOnTrigger = function(npc)
        -- toggle gates between open and close animations
        -- gates are grouped in groups of five. even numbered groups share one animation, while odd numbered groups share the other.

        local animEven = (npc:getAnimation() == xi.anim.OPEN_DOOR) and xi.anim.CLOSE_DOOR or xi.anim.OPEN_DOOR
        local animOdd  = (npc:getAnimation() == xi.anim.OPEN_DOOR) and xi.anim.OPEN_DOOR or xi.anim.CLOSE_DOOR

        for i = 0, 19 do
            local group = math.floor(i / 5)
            local anim = (group % 2 == 0) and animEven or animOdd
            GetNPCByID(ID.npc.GATE_OFFSET + i):setAnimation(anim)
        end

        -- toggle plates between open and close animations
        for i = 20, 27 do
            GetNPCByID(ID.npc.GATE_OFFSET + i):setAnimation(animEven)
        end
    end,
}

return THE_ELDIEME_NECROPOLIS
