-----------------------------------
-- Area: Port Windurst
--   NPC: Mojo-Pojo
-- Type: Standard NPC
-- !pos -108.041 -4.25 109.545 240
-----------------------------------
require("scripts/globals/npc_util")
require("scripts/globals/settings")
require("scripts/globals/magic")
-----------------------------------

function onSpawn(npc)
    npcUtil.castingAnimation(npc, tpz.magic.spellGroup.BLACK, 14)
end

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(229)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
