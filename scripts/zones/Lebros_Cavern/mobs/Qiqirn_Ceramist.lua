-----------------------------------
-- Area: Lebros Cavern (Excavation Duty)
--  Mob: Qiqirn Ceramist
-----------------------------------
local ID = require("scripts/zones/Lebros_Cavern/IDs")
-----------------------------------

function onMobSpawn(mob)
end

function onMobDeath(mob, player, isKiller)
    if math.random(0, 100) >= 50 and isKiller == true then
        player:addTempItem(5331)
        player:messageSpecial(ID.text.TEMP_ITEM, 5331)
    end
end

function onMobDespawn(mob)
end
