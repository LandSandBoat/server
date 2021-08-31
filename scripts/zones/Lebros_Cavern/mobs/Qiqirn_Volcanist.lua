-----------------------------------
-- Area: Lebros Cavern (Excavation Duty)
--  Mob: Qiqirn Volcanist
-----------------------------------
local ID = require("scripts/zones/Lebros_Cavern/IDs")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
end

entity.onMobDeath = function(mob, player, isKiller)
    if math.random(0, 100) >= 50 and isKiller == true then
        player:addTempItem(5331)
        player:messageSpecial(ID.text.TEMP_ITEM, 5331)
    end
end

entity.onMobDespawn = function(mob)
end

return entity
