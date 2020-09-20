-----------------------------------
-- Area: Port Windurst
--  NPC: Satata
-- Working 100%
-----------------------------------
require("scripts/globals/npc_util")
require("scripts/globals/settings")
require("scripts/globals/magic")
-----------------------------------

function onSpawn(npc)
    npcUtil.castingAnimation(npc, tpz.magic.spellGroup.BLACK, 12)
end

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(235)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
