-----------------------------------
-- Valkurm Mobs Era Module
-----------------------------------
require("modules/era/lua/dynamis/globals/era_dynamis")
require("modules/era/lua/dynamis/globals/era_dynamis_spawning")
require("scripts/globals/dynamis")
require("scripts/globals/zone")
-----------------------------------

xi = xi or {}
xi.dynamis = xi.dynamis or {}

xi.dynamis.onSpawnCirrate = function(mob)
    mob:setRoamFlags(xi.roamFlag.EVENT)
    xi.dynamis.setMegaBossStats(mob)
    -- Set Mods
    mob:speed(140)
    mob:addMod(xi.mod.REGAIN, 1250)
    mob:SetAutoAttackEnabled(false)
end

xi.dynamis.onSpawnFairy = function(mob)
    mob:speed(140)
    xi.dynamis.onSpawnNoAuto(mob)
end

xi.dynamis.onFightMorbol = function(mob, target)
    local cirrateID = mob:getLocalVar("ParentID")
    mob:speed(GetMobByID(cirrateID):getSpeed())
end

xi.dynamis.onEngagedCirrate = function(mob, target)
    local petIndex = {289, 290}
    local oMobIndex = mob:getLocalVar("MobIndex_%s", mob:getID())
    if not GetMobByID(zone:getLocalVar("Dragontrap")):isAlive() then
        for _, index in pairs(petIndex) do
            xi.dynamis.nmDynamicSpawn(index, oMobIndex, true, mob:getZoneID(), target, mob)
        end
    end
end

xi.dynamis.onFightCirrate = function(mob, target)
    local zone = mob:getZone()
    if not GetMobByID(zone:getLocalVar("Dragontrap")) then
        mob:setLocalVar("putridbreathcap", 500)
    end

    if not GetMobByID(zone:getLocalVar("Fairy Ring")):isAlive() then
        if mob:getSpeed() > 40 then
            mob:speed(40)
        end
        mob:setLocalVar("miasmicbreathpower", 30)
    end

    if not GetMobByID(zone:getLocalVar("Nanatina")):isAlive() then
        mob:setLocalVar("fragrantbreathduration", 30)
    end

    if not GetMobByID(zone:getLocalVar("Stcemqestcint")):isAlive() then
        mob:setLocalVar("vampiriclashpower", 1)
    end
end

xi.dynamis.onWeaponskillPrepCirrate = function(mob)
    -- Set Locals
    local skillList = -- All chance values are the max value they will go until.
    {
    --  [skillID] = {chance, "Mob's Name"},
        [1607] = {20, "Nantina"}, -- Fragrant Breath
        [1605] = {20, "Fairy Ring"}, -- Miasmic Breath
        [1609] = {20, "Dragontrap"}, -- Putrid Breath
        [1611] = {20, "Stcemqestcint"}, -- Vampiric Lash
        [1610] = {20, "Cirrate Christelle"}, -- Extremely Bad Breath
    }

    for skill, skillchoice in pairs(skillList) do
        local mobVar = skillchoice[2]
        if not GetMobByID(zone:getLocalVar(mobVar)):isAlive() then
            if skill == 1607 then
                skillList[skill] = {12, mobVar} -- Updates first entry to 12 if the mob is dead.
            else
                skillList[skill] = {(12 + skillList[skill-1][1]), mobVar} -- Updates the entry to 12 + last entry.
            end
        else
            if skill == 1607 then
                skillList[skill] = {20, mobVar} -- Leaves first entry at 20 if the mob is alive.
            else
                skillList[skill] = {(20 + skillList[skill-1][1]), mobVar} -- Updates entry at 20 + last entry if mob is alive.
            end
        end
    end

    local randomchance = math.random(1, skillList[1610][1]) -- Will random 1 to the chance of Extremely Bad Breath

    for skill, chance in pairs(skillList) do -- Checks all skills and their chances.
        if chance[1] >= randomchance then -- If chance is less than or equal to skill, use it.
            return skill -- USE THE SKILL LELELLELEL HOPE ITS EXTREMELY BAD BREATH
        end
    end
end

xi.dynamis.onWeaponskillPrepNantina = function(mob)
    local charm = math.random(1, 100)

    if charm <= 10 then
        return 1619 -- Attractant
    else
        if mob:getHPP() > 25 then
            return 1617
        else
            return 1618
        end
    end
end
