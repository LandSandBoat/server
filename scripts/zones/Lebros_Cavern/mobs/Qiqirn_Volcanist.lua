-----------------------------------
-- Area: Lebros Cavern (Excavation Duty)
--  Mob: Qiqirn Volcanist
-----------------------------------
local ID = zones[xi.zone.LEBROS_CAVERN]
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    xi.assault.adjustMobLevel(mob)
end

entity.onMobDeath = function(mob, player, optParams)
    if mob:getLocalVar('dead') == 0 then
        mob:setLocalVar('dead', 1)
        if math.random(0, 100) >= 50 then
            player:addTempItem(xi.item.QIQIRN_MINE)
            player:messageSpecial(ID.text.TEMP_ITEM, xi.item.QIQIRN_MINE)
        end
    end
end

entity.onMobDespawn = function(mob)
end

return entity
