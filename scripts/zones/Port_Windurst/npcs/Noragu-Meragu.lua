-----------------------------------
-- Area: Port Windurst
--  NPC: Noragu-Meragu
-- Working 100%
-----------------------------------
require("scripts/globals/npc_util")
require("scripts/globals/settings")
require("scripts/globals/magic")
-----------------------------------

function onSpawn(npc)
    npcUtil.castingAnimation(npc, tpz.magic.spellGroup.BLACK, 10)
end

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(236)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
