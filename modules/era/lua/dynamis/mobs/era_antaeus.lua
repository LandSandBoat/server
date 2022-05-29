-----------------------------------
-- Antaeus Era Module
-----------------------------------
require("scripts/globals/dynamis")
require("scripts/globals/zone")
-----------------------------------

xi = xi or {}
xi.dynamis = xi.dynamis or {}

xi.dynamis.onSpawnAntaeus = function(mob)
    xi.dynamis.setMegaBossStats(mob)
    -- Set Removable Mods
    mob:addMod(xi.mod.REGEN, 1000)
    mob:addMod(xi.mod.CRITHITRATE, 100)
    mob:addMod(xi.mod.UDMGRANGE, -99)
    mob:addMod(xi.mod.UDMGPHYS, -99)
    mob:addMod(xi.mod.UDMGBREATH, -99)
    mob:addMod(xi.mod.FIRERES, 1000)
    mob:addMod(xi.mod.ICERES, 1000)
    mob:addMod(xi.mod.WINDRES, 1000)
    mob:addMod(xi.mod.EARTHRES, 1000)
    mob:addMod(xi.mod.THUNDERRES, 1000)
    mob:addMod(xi.mod.WATERRES, 1000)
    mob:addMod(xi.mod.LIGHTRES, 1000)
    mob:addMod(xi.mod.DARKRES, 1000)
    -- Set Non-Removable Mods
    -- Anateus should not standback and should be able to avoid most RAs via melee range. (https://ffxiclopedia.fandom.com/wiki/Antaeus)
    mob:addMobMod(xi.mobMod.NO_STANDBACK, 1)
    -- Sleep Res and Lullaby Res are unverified but added in case (https://ffxiclopedia.fandom.com/wiki/Antaeus)
    mob:addMod(xi.mod.SLEEPRES, 99)
    mob:addMod(xi.mod.LULLABYRES, 99)
    -- Adding Normal Dynamis Boss Resistances and Regain
    mob:addMod(xi.mod.GRAVITYRES, 40)
    mob:addMod(xi.mod.BINDRES, 40)
    mob:addMod(xi.mod.REGAIN, 50)
end

xi.dynamis.onEngagedAntaeus = function(mob, target)
    xi.dynamis.parentOnEngaged(mob, target)
end

xi.dynamis.onFightAntaeus = function(mob, target)
    local zone = mob:getZone()
    -- Remove Mods Per NM or Elemental Kill
    if not GetMobByID(zone:getLocalVar("Scolopendra")):isAlive() then
        if mob:getMod(xi.mod.REGEN) ~= 0 then
            mob:setMod(xi.mod.REGEN, 0)
        end
    end
    if not GetMobByID(zone:getLocalVar("Stringes")):isAlive() then
        if mob:getMod(xi.mod.CRITHITRATE) ~= 10 then
            mob:setMod(xi.mod.CRITHITRATE, 10)
        end
    end
    if not GetMobByID(zone:getLocalVar("Suttung")):isAlive() then
        if mob:getMod(xi.mod.UDMGPHYS) ~= 0 then
            mob:setMod(xi.mod.UDMGRANGE, 0)
            mob:setMod(xi.mod.UDMGPHYS, 0)
            mob:setMod(xi.mod.UDMGBREATH, 0)
            mob:setMod(xi.mod.UDMGRANGE, 0)
        end
    end
    if not GetMobByID(zone:getLocalVar("Fire_Elemental")):isAlive() then
        if mob:getMod(xi.mod.FIRERES) ~= 0 then
            mob:setMod(xi.mod.FIRERES, 0)
        end
    end
    if not GetMobByID(zone:getLocalVar("Ice_Elemental")):isAlive() then
        if mob:getMod(xi.mod.ICERES) ~= 0 then
            mob:setMod(xi.mod.ICERES, 0)
        end
    end
    if not GetMobByID(zone:getLocalVar("Air_Elemental")):isAlive() then
        if mob:getMod(xi.mod.WINDRES) ~= 0 then
            mob:setMod(xi.mod.WINDRES, 0)
        end
    end
    if not GetMobByID(zone:getLocalVar("Earth_Elemental")):isAlive() then
        if mob:getMod(xi.mod.EARTHRES) ~= 0 then
            mob:setMod(xi.mod.EARTHRES, 0)
        end
    end
    if not GetMobByID(zone:getLocalVar("Thunder_Elemental")):isAlive() then
        if mob:getMod(xi.mod.THUNDERRES) ~= 0 then
            mob:setMod(xi.mod.THUNDERRES, 0)
        end
    end
    if not GetMobByID(zone:getLocalVar("Water_Elemental")):isAlive() then
        if mob:getMod(xi.mod.WATERRES) ~= 0 then
            mob:setMod(xi.mod.WATERRES, 0)
        end
    end
    if not GetMobByID(zone:getLocalVar("Light_Elemental")):isAlive() then
        if mob:getMod(xi.mod.LIGHTRES) ~= 0 then
            mob:setMod(xi.mod.LIGHTRES, 0)
        end
    end
    if not GetMobByID(zone:getLocalVar("Dark_Elemental")):isAlive() then
        if mob:getMod(xi.mod.DARKRES) ~= 0 then
            mob:setMod(xi.mod.DARKRES, 0)
        end
    end
end

xi.dynamis.onMobRoamAntaeus = function(mob) xi.dynamis.mobOnRoam(mob) end
xi.dynamis.onMobRoamActionAntaeus = function(mob) xi.dynamis.mobOnRoamAction(mob) end
xi.dynamis.onMobDeathAntaeus = function(mob, player, isKiller) xi.dynamis.megaBossOnDeath(mob, player, mobVar) end