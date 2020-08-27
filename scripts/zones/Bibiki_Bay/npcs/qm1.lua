-----------------------------------
-- Area:  Bibiki Bay
-- NPC:   ??? (qm1)
-- Notes: Used to spawn Shen
-- !pos -115.108 0.300 -724.664 4
-----------------------------------
local ID = require("scripts/zones/Bibiki_Bay/IDs")

function onTrade(player, npc, trade)
    if (not GetMobByID(ID.mob.SHEN):isSpawned() and trade:hasItemQty(1823, 1) and trade:getItemCount() == 1) then
        player:tradeComplete()
        SpawnMob(ID.mob.SHEN):updateClaim(player)
        for i = 1, 2 do
            if (not GetMobByID(ID.mob.SHEN+i):isSpawned()) then
                SpawnMob(ID.mob.SHEN+i):updateEnmity(player)
            end
        end
    end
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
