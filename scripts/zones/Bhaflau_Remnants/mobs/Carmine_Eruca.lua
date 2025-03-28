-----------------------------------
-- Area: Bhaflau Remnants
--  MOB: Carmine Eruca
-----------------------------------
require('scripts/zones/Bhaflau_Remnants/globals/zoneUtil')
-----------------------------------

---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setDelay(300)
    mob:setMod(xi.mod.ATT, 101)
    mob:setMod(xi.mod.MAIN_DMG_RATING, -55)
    mob:addListener('ITEM_DROPS', 'ERUCA_ITEM_DROPS', function(mobArg, loot)
        -- Drops 3 Cells from list in up to multiples of 3
        -- 1st Cell always 3, 2nd set 2-3, 3rd set 0-3
        local cell1, cell2, cell3 = xi.zoneUtil.pickList(mobArg)

        loot:addItem(cell1, xi.drop_rate.GUARANTEED)
        loot:addItem(cell1, xi.drop_rate.GUARANTEED)
        loot:addItem(cell1, xi.drop_rate.GUARANTEED)

        loot:addItem(cell2, xi.drop_rate.GUARANTEED)
        loot:addItem(cell2, xi.drop_rate.VERY_COMMON)
        loot:addItem(cell2, xi.drop_rate.VERY_COMMON)

        loot:addItem(cell3, xi.drop_rate.VERY_COMMON)
        loot:addItem(cell3, xi.drop_rate.VERY_COMMON)
        loot:addItem(cell3, xi.drop_rate.VERY_COMMON)
    end)
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        xi.salvage.spawnTempChest(mob)
    end
end

return entity
