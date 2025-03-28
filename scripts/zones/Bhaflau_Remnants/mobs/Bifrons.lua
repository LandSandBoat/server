-----------------------------------
-- Area: Bhaflau Remnants
--  MOB: Bifrons
-----------------------------------
require('scripts/zones/Bhaflau_Remnants/globals/zoneUtil')
-----------------------------------

---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:addListener('ITEM_DROPS', 'BIFRONS_ITEM_DROPS', function(mobArg, loot)
        local cell1, cell2, cell3 = xi.zoneUtil.pickList(mobArg)

        loot:addItem(cell1, xi.drop_rate.VERY_COMMON)
        loot:addItem(cell1, xi.drop_rate.VERY_COMMON)
        loot:addItem(cell2, xi.drop_rate.VERY_COMMON)
        loot:addItem(cell2, xi.drop_rate.VERY_COMMON)
        loot:addItem(cell3, xi.drop_rate.VERY_COMMON)
        loot:addItem(cell3, xi.drop_rate.VERY_COMMON)
    end)

    -- only appear on floor 1, and damage and delay are altered
    mob:addListener('AFTER_SPAWN', 'BIFRONS_AFTER_SPAWN', function(mobArg)
        mobArg:setDelay(330)
        mobArg:setMod(xi.mod.ATT, 150)
        mobArg:setMod(xi.mod.MAIN_DMG_RATING, -35)
        mobArg:setMod(xi.mod.MATT, -57)
        mobArg:setMod(xi.mod.INT, -20)
    end)
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        xi.salvage.spawnTempChest(mob)
    end
end

return entity
