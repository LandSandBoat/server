-----------------------------------
-- Area: Ifrit's Cauldron
--  NPC: qm1 (???)
-- Notes: Used to spawn Tarasque
-- !pos 126 18 166 205
-----------------------------------
local ID = require("scripts/zones/Ifrits_Cauldron/IDs")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHas(trade, 1189) and
        npcUtil.popFromQM(player, npc, ID.mob.TARASQUE, { claim = false, look = true })
    then
        -- Rattling Egg
        player:confirmTrade()
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.EGGSHELLS_LIE_SCATTERED)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
