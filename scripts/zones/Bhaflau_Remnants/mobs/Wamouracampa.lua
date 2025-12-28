-----------------------------------
-- Area: Bhaflau Remnants
--  MOB: Wamouracampa
-----------------------------------
require('scripts/zones/Bhaflau_Remnants/globals/zoneUtil')
-----------------------------------

---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    -- having to copy the mixin due to the strange damage values
    mob:addListener('SPAWN', 'WAMOURACAMPA_SPAWN', function(mobArg)
        mobArg:setLocalVar('formTime', GetSystemTime() + math.random(45, 60))
    end)

    mob:addListener('DISENGAGE', 'WAMOURACAMPA_DISENGAGE', function(mobArg)
        mobArg:setLocalVar('formTime', GetSystemTime() + math.random(45, 60))
    end)

    mob:addListener('ROAM_TICK', 'WAMOURACAMPA_ROAM', function(mobArg)
        local roamTime = mobArg:getLocalVar('formTime')

        if GetSystemTime() > roamTime then
            if mobArg:getAnimationSub() == 0 then
                mobArg:setAnimationSub(1)
                mobArg:setMod(xi.mod.DMGPHYS, 0)
                mobArg:setMod(xi.mod.DMGRANGE, 0)
                mobArg:setMod(xi.mod.UDMGMAGIC, 1500)
                mobArg:setMod(xi.mod.UDMGBREATH, 150)
                mobArg:setLocalVar('damageThreshold', math.random(5, 15) / 100 * mobArg:getMaxHP())
            else
                mobArg:setAnimationSub(0)
                mobArg:setMod(xi.mod.DMGPHYS, -25)
                mobArg:setMod(xi.mod.DMGRANGE, -25)
                mobArg:setMod(xi.mod.UDMGMAGIC, 2000)
                mobArg:setMod(xi.mod.UDMGBREATH, 200)
                mobArg:setLocalVar('damageThreshold', 0)
            end

            mobArg:setLocalVar('formTime', GetSystemTime() + math.random(45, 60))
        end
    end)

    mob:addListener('TAKE_DAMAGE', 'WAMOURACAMPA_TAKE_DAMAGE', function(mobArg, damage, attacker, attackType, damageType)
        local damageThreshold = mobArg:getLocalVar('damageThreshold')

        if damage >= mobArg:getMaxHP() * 0.1 then
            if mobArg:getAnimationSub() == 0 then
                mobArg:setAnimationSub(1)
                mobArg:setMod(xi.mod.DMGPHYS, 0)
                mobArg:setMod(xi.mod.DMGRANGE, 0)
                mobArg:setMod(xi.mod.UDMGMAGIC, 1500)
                mobArg:setMod(xi.mod.UDMGBREATH, 150)
            end

            damageThreshold = math.random(10, 50) / 100 * mobArg:getMaxHP()
        elseif mobArg:getAnimationSub() == 1 then
            if damageThreshold < damage then
                mobArg:setAnimationSub(0)
                mobArg:setMod(xi.mod.DMGPHYS, -25)
                mobArg:setMod(xi.mod.DMGRANGE, -25)
                mobArg:setMod(xi.mod.UDMGMAGIC, 2000)
                mobArg:setMod(xi.mod.UDMGBREATH, 200)
                damageThreshold = 0
            else
                damageThreshold = damageThreshold - damage
            end
        end

        mobArg:setLocalVar('damageThreshold', damageThreshold)
    end)

    mob:addListener('ITEM_DROPS', 'WAMOURACAMPA_ITEM_DROPS', function(mobArg, loot)
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

    -- only appear on floor 1, and damage and delay are altered
    mob:addListener('AFTER_SPAWN', 'WAMOURACAMPA_AFTER_SPAWN', function(mobArg)
        mobArg:setDelay(330)
        mobArg:setMod(xi.mod.ATT, 101)
        mobArg:setMod(xi.mod.MAIN_DMG_RATING, -45)
    end)

    -- only appear on floor 1, and damage and delay are altered
    mob:addListener('AFTER_SPAWN', 'WAMOURACAMPA_AFTER_SPAWN', function(mobArg)
        mobArg:setDelay(330)
        mobArg:setMod(xi.mod.ATT, 101)
        mobArg:setMod(xi.mod.MAIN_DMG_RATING, -45)
        mobArg:setMod(xi.mod.INT, -35)
        mobArg:setMod(xi.mod.MATT, -15)
    end)
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        xi.salvage.spawnTempChest(mob)
    end
end

return entity
