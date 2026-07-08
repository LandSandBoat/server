-----------------------------------
-- Area: Bhaflau Remnants
--  MOB: Troll Cameist
-----------------------------------
local ID = zones[xi.zone.BHAFLAU_REMNANTS]
mixins = { require('scripts/mixins/weapon_break') }
require('scripts/zones/Bhaflau_Remnants/globals/zoneUtil')
-----------------------------------

---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:addListener('ITEM_DROPS', 'CAMEIST_ITEM_DROPS', function(mobArg, loot)
        local instance = mobArg:getInstance()

        if instance then
            local floor = instance:getStage()

            if floor == 1 then
                local cell1, cell2, cell3 = xi.zoneUtil.pickList(mobArg)
                loot:addItem(cell1, xi.drop_rate.VERY_COMMON)
                loot:addItem(cell1, xi.drop_rate.VERY_COMMON)

                loot:addItem(cell2, xi.drop_rate.VERY_COMMON)
                loot:addItem(cell2, xi.drop_rate.VERY_COMMON)

                loot:addItem(cell3, xi.drop_rate.VERY_COMMON)
                loot:addItem(cell3, xi.drop_rate.VERY_COMMON)
            else
                local cell1, cell2, cell3, cell4 = xi.zoneUtil.pickList(mobArg)
                local mobID = mobArg:getID()
                if utils.contains(mobID, utils.slice(ID.mob.TROLL_CAMEIST, 9, 10)) then
                    loot:addItem(xi.item.INCUS_CELL, xi.drop_rate.VERY_COMMON)
                end

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
