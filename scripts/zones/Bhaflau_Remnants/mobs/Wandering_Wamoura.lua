-----------------------------------
-- Area: Bhaflau Remnants
--  MOB: Wandering Wamoura
-----------------------------------
require('scripts/zones/Bhaflau_Remnants/globals/zoneUtil')
-----------------------------------

---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.UDMGMAGIC, 1000)
    mob:setMod(xi.mod.UDMGPHYS, 50)
    mob:setMod(xi.mod.UDMGRANGE, 50)
    mob:setMod(xi.mod.UDMGBREATH, 100)
    mob:addListener('ITEM_DROPS', 'WAMOURA_ITEM_DROPS', function(mobArg, loot)
        local instance = mob:getInstance()

        if instance then
            local floor = instance:getStage()

            if floor > 1 then
                local cell1, cell2, cell3, cell4 = xi.zoneUtil.pickList(mobArg)

                loot:addItem(cell1, xi.drop_rate.VERY_COMMON)
                loot:addItem(cell1, xi.drop_rate.VERY_COMMON)

                loot:addItem(cell2, xi.drop_rate.VERY_COMMON)
                loot:addItem(cell2, xi.drop_rate.VERY_COMMON)

                loot:addItem(cell3, xi.drop_rate.GUARANTEED)
                loot:addItem(cell3, xi.drop_rate.GUARANTEED)
                loot:addItem(cell3, xi.drop_rate.GUARANTEED)

                loot:addItem(cell4, xi.drop_rate.VERY_COMMON)
                loot:addItem(cell4, xi.drop_rate.VERY_COMMON)
                loot:addItem(cell4, xi.drop_rate.VERY_COMMON)
            end
        end
    end)
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        xi.salvage.spawnTempChest(mob)
    end
end

return entity
