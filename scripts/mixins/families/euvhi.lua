-----------------------------------
-- Euvhi Family Mixin
-----------------------------------
-- Forms: 0 = Closed (no stem)  1 = Closed (stem)  2 = Open 3 = Open (closes while melee)
-- According to http://wiki.ffxiclopedia.org/wiki/Category:Euvhi
-- When in an open state, damage taken by the Euvhi is doubled. Inflicting a large amount of damage to an Euvhi in an open state will cause it to close.
-- TODO: Initial DOT Damage will count as "Magical Damage", need to track dot ticks.
-----------------------------------
require("scripts/globals/mixins")
require("scripts/globals/magic")
-----------------------------------
xi = xi or {}
xi.mix = xi.mix or {}
xi.mix.euvhi = xi.mix.euvhi or {}

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

local function openFlower(mob)
    mob:setLocalVar("PhysicalDamage", 0)
    mob:setLocalVar("MagicalDamage", 0)
    mob:setLocalVar("RangedDamage", 0)
    mob:setLocalVar("BreathDamage", 0)
    mob:delMod(xi.mod.ATTP, 10)
    mob:setMod(xi.mod.HTH_SDT, 2000)
    mob:setMod(xi.mod.SLASH_SDT, 2000)
    mob:setMod(xi.mod.PIERCE_SDT, 2000)
    mob:setMod(xi.mod.IMPACT_SDT, 2000)
    mob:setMod(xi.mod.UDMGMAGIC, 5000) -- Takes double damage from all sources when open
    mob:setMod(xi.mod.UDMGPHYS, 5000) -- Takes double damage from all sources when open
    mob:setMod(xi.mod.UDMGRANGE, 5000) -- Takes double damage from all sources when open
    mob:setMod(xi.mod.UDMGBREATH, 5000) -- Takes double damage from all sources when open
    mob:setAnimationSub(2)
end

local function closeFlower(mob)
    mob:setLocalVar("PhysicalDamage", 0)
    mob:setLocalVar("MagicalDamage", 0)
    mob:setLocalVar("RangedDamage", 0)
    mob:setLocalVar("BreathDamage", 0)
    mob:addMod(xi.mod.ATTP, 10) -- euvhi hits hard while flower is closed
    mob:setMod(xi.mod.HTH_SDT, 1000)
    mob:setMod(xi.mod.SLASH_SDT, 1000)
    mob:setMod(xi.mod.PIERCE_SDT, 1000)
    mob:setMod(xi.mod.IMPACT_SDT, 1000)
    mob:setMod(xi.mod.UDMGMAGIC, 0) -- Takes predicted damage when open
    mob:setMod(xi.mod.UDMGPHYS, 0) -- Takes predicted damage when open
    mob:setMod(xi.mod.UDMGRANGE, 0) -- Takes predicted damage when open
    mob:setMod(xi.mod.UDMGBREATH, 0) -- Takes predicted damage when open
    mob:setLocalVar("[euvhi]changeTime", mob:getBattleTime() + 80) -- Flower will open after 80 seconds
    mob:setAnimationSub(1)
end

g_mixins.families.euvhi = function(euvhiArg)
    euvhiArg:addListener("SPAWN", "EUVHI_SPAWN", function(mob)
        mob:setLocalVar("PhysicalDamage", 0)
        mob:setLocalVar("MagicalDamage", 0)
        mob:setLocalVar("RangedDamage", 0)
        mob:setLocalVar("BreathDamage", 0)
    end)

    euvhiArg:addListener("ENGAGE", "EUVHI_ENGAGE", function(mob)
        if mob:getAnimationSub() == 0 then
            mob:setAnimationSub(1) -- stem will appear after engaging target
        end

        mob:setLocalVar("PhysicalDamage", 0)
        mob:setLocalVar("MagicalDamage", 0)
        mob:setLocalVar("RangedDamage", 0)
        mob:setLocalVar("BreathDamage", 0)
        mob:setLocalVar("[euvhi]changeTime", math.random(15, 30)) -- wait 15-30 seconds to open flower after engaging
    end)

    euvhiArg:addListener("ROAM_TICK", "EUVHI_RTICK", function(mob)
        if mob:getHPP() == 100 then
            mob:setLocalVar("PhysicalDamage", 0)
            mob:setLocalVar("MagicalDamage", 0)
            mob:setLocalVar("RangedDamage", 0)
            mob:setLocalVar("BreathDamage", 0)
        end
    end)

    euvhiArg:addListener("TAKE_DAMAGE", "EUVHI_TAKE_DAMAGE", function(mob, amount, attacker, attackType, damageType)
        if attackType == xi.attackType.PHYSICAL then
            mob:setLocalVar("PhysicalDamage", mob:getLocalVar("PhysicalDamage") + amount)
        elseif attackType == xi.attackType.MAGICAL then
            mob:setLocalVar("MagicalDamage", mob:getLocalVar("MagicalDamage") + amount)
        elseif attackType == xi.attackType.RANGED then
            mob:setLocalVar("RangedDamage", mob:getLocalVar("RangedDamage") + amount)
        elseif attackType == xi.attackType.BREATH then
            mob:setLocalVar("BreathDamage", mob:getLocalVar("BreathDamage") + amount)
        end
    end)

    euvhiArg:addListener("COMBAT_TICK", "EUVHI_CTICK", function(mob)
        local sum = mob:getLocalVar("PhysicalDamage") + mob:getLocalVar("MagicalDamage") + mob:getLocalVar("RangedDamage") + mob:getLocalVar("BreathDamage")
        if
            mob:getAnimationSub() == 2 and
            sum > 350
        then
            closeFlower(mob)
        elseif
            mob:getAnimationSub() == 1 and
            mob:getBattleTime() > mob:getLocalVar("[euvhi]changeTime")
        then
            openFlower(mob)
        end
    end)
end

return g_mixins.families.euvhi
