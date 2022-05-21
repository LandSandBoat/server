-----------------------------------
-- Cirrate Christelle Era Module
-----------------------------------
require("modules/module_utils")
require("scripts/globals/zone")
-----------------------------------
local m = Module:new("era_cirrate_christelle")

m:addOverride("xi.zones.Dynamis-Valkurm.mobs.Cirrate_Christelle.onMobSpawn", function(mob)
    xi.dynamis.setMegaBossStats(mob)
    -- Set Mods
    mob:speed(140)
    mob:addMod(xi.mod.REGAIN, 1250)
    mob:SetAutoAttackEnabled(false)
end)

m:addOverride("xi.zones.Dynamis-Valkurm.mobs.Cirrate_Christelle.onMobFight", function(mob, target)
    local zone = mob:getZone()
    if not GetMobByID(zone:getLocalVar("Dragontrap_1")):isAlive() and GetMobByID(zone:getLocalVar("Dragontrap_2")):isAlive() and GetMobByID(zone:getLocalVar("Dragontrap_3")):isAlive() then
        if mob:getLocalVar("PetsSpawned") ~= 1 then
        local OMobIndex = mobIndex
        local oMob = mob
        local i = 1
        local pets =
        {
            {"4650756b" , 130, 134, 0, nil, nil}, -- FPuk
        }
            while i <= 2 do
                local mob = zone:insertDynamicEntity({
                    objtype = xi.objType.MOB,
                    name = pets[1],
                    x = oMob:getXPos()+math.random()*6-3,
                    y = oMob:getYPos()-0.3,
                    z = oMob:getXPos()+math.random()*6-3,
                    rotation = oMob:getRotPos(),
                    groupId = pets[2],
                    groupZoneId = pets[3],
                    onMobSpawn = function(mob) xi.dynamis.setNMStats(mob) end,
                    onMobRoam = function(mob) xi.dynamis.mobOnRoam(mob) end,
                    onMobFight = function(mob) xi.dynamis.mobOnFight(mob) end,
                    onMobRoamAction = function(mob) xi.dynamis.mobOnRoamAction(mob) end,
                    onMobDeath = function(mob, playerArg, isKiller)
                        xi.dynamis.mobOnDeath(mob, mobList[mob:getZoneID()], zones[mob:getZoneID()].text.DYNAMIS_TIME_EXTEND)
                    end,
                })
                mob:setSpawn(oMob:getXPos()+math.random()*6-3, oMob:getYPos()-0.3, oMob:getZPos()+math.random()*6-3, oMob:getRotPos())
                mob:setDropID(pets[4])
                if pets[5] ~= nil then -- If SpellList ~= nil set SpellList
                    mob:setSpellList(pets[5])
                end
                if pets[6] ~= nil then -- If SkillList ~= nil set SkillList
                    mob:setMobMod(xi.mobMod.SKILL_LIST, pets[6])
                end
                mob:setMobMod(xi.mobMod.SUPERLINK, 1)
                oMob:setLocalVar(string.format("Nightmare_Morbol_%i", i), mob:getID())
                mob:setLocalVar("PetMaster", OMobIndex)
                mob:spawn()
                mob:updateEnmity(target)
                if i == 2 then
                    mob:setLocalVar("PetsSpawned", 1)
                end
            end
            i = i + 1
        end
    end

    if not GetMobByID(zone:getLocalVar("Dragontrap_1")):isAlive() and GetMobByID(zone:getLocalVar("Dragontrap_2")):isAlive() and GetMobByID(zone:getLocalVar("Dragontrap_3")):isAlive() then
        mob:setLocalVar("putridbreathcap", 500)
    end
    if not GetMobByID(zone:getLocalVar("Fairy_Ring")):isAlive() then
        mob:speed(40)
        mob:setLocalVar("miasmicbreathpower", 30)
    end
    if not GetMobByID(zone:getLocalVar("Nanatina")):isAlive() then
        mob:setLocalVar("fragrantbreathduration", 30)
    end
    if not GetMobByID(zone:getLocalVar("Stcemqestcint")):isAlive() then
        mob:setLocalVar("vampiriclashpower", 1)
    end
end)



m:addOverride("xi.zones.Dynamis-Valkurm.mobs.Cirrate_Christelle.onMobWeaponskillPrepare", function(mob, target)
    -- Set Locals
    local fragrantbreath = 24
    local miasmicbreath = 24
    local putridbreath = 24
    local vampiriclash = 24
    local randomchance = math.random(1, 100)
    local totalchance = 100

    -- Set Probabilities of Each Skill Based on NM Kill Status
    if not GetMobByID(zone:getLocalVar("Nanatina")):isAlive() then
        fragrantbreath = 12
    end
    if not GetMobByID(zone:getLocalVar("Fairy_Ring")):isAlive() then
        miasmicbreath = 12
    end
    if not GetMobByID(zone:getLocalVar("Dragontrap_1")):isAlive() and GetMobByID(zone:getLocalVar("Dragontrap_2")):isAlive() and GetMobByID(zone:getLocalVar("Dragontrap_3")):isAlive() then
        putridbreath = 12
    end
    if not GetMobByID(zone:getLocalVar("Stcemqestcint")):isAlive() then
        vampiriclash = 12
    end

    -- Choose Skill
    if randomchance >= (totalchance - fragrantbreath) then
        return 1607 -- Fragrant Breath
    elseif randomchance >= (totalchance - (fragrantbreath + miasmicbreath)) then
        return 1605 -- Miasmic Breath
    elseif randomchance >= (totalchance - (fragrantbreath + miasmicbreath + putridbreath)) then
        return 1609 -- Putrid Breath
    elseif randomchance >= (totalchance - (fragrantbreath + miasmicbreath + putridbreath + vampiriclash)) then
        return 1611 -- Vampiric Lash
    else
        return 1610 -- Extremely Bad Breath: Gains Chance as Other Skills are Mitigated
    end
end)

m:addOverride("xi.zones.Dynamis-Valkurm.mobs.Cirrate_Christelle.onMobEngaged", function(mob, target) xi.dynamis.parentOnEngaged(mob, target) end)
m:addOverride("xi.zones.Dynamis-Valkurm.mobs.Cirrate_Christelle.onMobRoam", function(mob) xi.dynamis.mobOnRoam(mob) end)

return m