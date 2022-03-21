-----------------------------------
-- Area:  Nyzul_Isle
-- NPC:   Armoury Crate
-- Notes: 100% drop from NMs for ??? items and ?% drop from normal mobs for Temp items
-----------------------------------
local ID = require("scripts/zones/Nyzul_Isle/IDs")
require("scripts/globals/utils")
require("scripts/globals/utils/nyzul")
-----------------------------------

function onTrigger(player, npc)
    if utils.tableContains(ID.npc.TREASURE_COFFER, npc:getID()) then
        xi.nyzul.handleAppraisalItem(player, npc)
    else
        xi.nyzul.tempBoxTrigger(player, npc)
    end
end

function onEventFinish(player, csid, option, npc)
    xi.nyzul.tempBoxFinish(player, csid, option, npc)
end
