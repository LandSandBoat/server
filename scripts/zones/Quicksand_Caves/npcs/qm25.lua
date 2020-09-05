-----------------------------------
-- Area: Quicksand Caves
--  NPC: qm25
--  Notes: Antican Tag
-----------------------------------
local ID = require("scripts/zones/Quicksand_Caves/IDs")
require("scripts/globals/npc_util")
-----------------------------------

function onTrigger(player, npc)
    if (npcUtil.giveItem(player, 1190)) then
        local newPosition = npcUtil.pickNewPosition(npc:getID(), ID.npc.ANTICAN_TAG_POSITIONS, true)
        npc:hideNPC(7200)
        npc:setPos(newPosition.x, newPosition.y, newPosition.z)
        SetServerVariable("[POP]Antican_Tag", os.time() + 7200) -- "pause" UpdateNPCSpawnPoint
    end
end
