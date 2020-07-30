-----------------------------------
-- Area: Castle Zvahl Baileys
--  NPC: Torch (x4)
-- Involved in Quests: Borghertz's Hands (AF Hands, Many job)
-- !pos 63 -24 21 161
-----------------------------------
local ID = require("scripts/zones/Castle_Zvahl_Baileys/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    -- killed Dark Spark and clicked same torch used to spawn
    if player:getCharVar("BorghertzSparkKilled") == 1 then
        npcUtil.giveKeyItem(player, tpz.ki.SHADOW_FLAMES)
        player:setCharVar("BorghertzSparkKilled", 0)
        player:setCharVar("BorghertzCS", 0)

    -- attempt to spawn Dark Spark from torch
    elseif
        player:hasKeyItem(tpz.ki.OLD_GAUNTLETS) and
        not player:hasKeyItem(tpz.ki.SHADOW_FLAMES) and
        player:getCharVar("BorghertzCS") >= 2 and
        npcUtil.popFromQM(player, npc, ID.mob.DARK_SPARK, {claim=true, hide=0})
    then
        player:messageSpecial(ID.text.SENSE_OF_FOREBODING)

    -- default dialog
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
