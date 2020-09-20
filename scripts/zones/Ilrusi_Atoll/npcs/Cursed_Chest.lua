-----------------------------------
-- Area: Ilrusi Atoll
--  NPC: Cursed Chest
-----------------------------------
local ID = require("scripts/zones/Ilrusi_Atoll/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.CHEST)

    local npcID = npc:getID()
    local instance = npc:getInstance()
    local figureheadChest = instance:getProgress()

    if (npcID == figureheadChest) then
        player:messageSpecial(ID.text.GOLDEN)
        instance:complete()
        for i, v in pairs(ID.mob[2]) do
            DespawnMob(v, instance)
        end
    else
        SpawnMob(npcID, instance):updateClaim(player)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
