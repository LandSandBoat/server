-----------------------------------
-- Area: Lebros Cavern (Excavation Duty)
--  Mob: Qiqirn Volcanist
-----------------------------------
local ID = zones[xi.zone.LEBROS_CAVERN]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    xi.assault.adjustMobLevel(mob)
    mob:setMobMod(xi.mobMod.GIL_MAX, -1)
end

entity.onMobDeath = function(mob, player, optParams)
    -- TODO: Check if only killer can get drop or any party member.
    if optParams.isKiller or optParams.noKiller then
        if not player then
            return
        end

        if player:hasItem(xi.item.QIQIRN_MINE, xi.inv.TEMPITEMS) then
            return
        end

        if math.randomInt(1, 100) > 40 then -- TODO: More Retail data. Current data is 47/127 for drops.
            return
        end

        if player:addTempItem(xi.item.QIQIRN_MINE) then
            player:messageSpecial(ID.text.TEMP_ITEM, xi.item.QIQIRN_MINE)
        end
    end
end

return entity
